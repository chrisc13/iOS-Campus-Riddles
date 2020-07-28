//
//  FirstViewController.swift
//  Campus Riddles
//
//  Created by Chris Carbajal on 7/15/20.
//  Copyright © 2020 Chris Carbajal. All rights reserved.
//

import UIKit

protocol RiddleRowSelection {
    //func didTapRiddleRow(title: String, difficulty: Int, prize: String, levels: Int, )
}



//let title: String
// let difficulty: Int
// let prize: String
// let levels: Int
// let description: String
// let riddlerName: String
class FirstViewController: UIViewController {

    @IBOutlet weak var riddlesTable: UITableView!

    
  //  var riddles: Riddles = Riddles()
    var riddlesRepository = [Riddle](){
        didSet{
            DispatchQueue.main.async {
                self.riddlesTable.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        riddlesTable.delegate = self
        riddlesTable.dataSource = self
        
        //serial queue: (move from background queue to main queue ==> for UI update)
        riddlesTable.reloadData()
        updateViewFromModel()
        
        let refreshControl = UIRefreshControl()
           refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)

           // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
         if #available(iOS 10.0, *) {
             riddlesTable.refreshControl = refreshControl
           } else {
             riddlesTable.addSubview(refreshControl)
           }
        
        
    }
    

    @objc func doSomething(refreshControl: UIRefreshControl) {
       updateViewFromModel()

        // somewhere in your code you might need to call:
        refreshControl.endRefreshing()
    }
    
    func updateViewFromModel(){
        WebSession.getRiddles{ [weak self] result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let riddles):
                self?.riddlesRepository = riddles
            }
        }
    }
}


//used to handle interactions of cells
extension FirstViewController: UITableViewDelegate{
    //handle tapping on row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
        let vc = storyboard?.instantiateViewController(withIdentifier: "RiddleDetailViewController") as! RiddleDetailViewController
        present(vc, animated: true, completion: nil)
    }
    
}

extension FirstViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(riddles.riddles.count)
        return riddlesRepository.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RiddleTableViewCell

        cell.titleLabel.text = riddlesRepository[indexPath.row].title
        cell.descriptionLabel.text = riddlesRepository[indexPath.row].description
        cell.riddlerNameLabel.text = riddlesRepository[indexPath.row].riddlerName
        
        return cell
    }
    
}
