//
//  ProgramaticalyConstrainVC.swift
//  DemoTopics
//
//  Created by Apple on 21/09/24.
//

import UIKit

class CardTableviewCell:UITableViewCell{
    
    let cardView    =  UIView()
    let image1      =  UIImageView()
    let lblTitle    =  UILabel()
    let lblSubTitle =  UILabel()
//    let img1 = UIImageView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
//    let lbl1 =  UILabel(frame: CGRect(x: 120, y: 20, width: 180, height: 30))
//    let lbl2 =  UILabel(frame: CGRect(x: 120, y: 60, width: 180, height: 30))
    
    override class func awakeFromNib() {
        super.awakeFromNib()

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func intializeCard(){
        
        self.selectionStyle = .none
        cardView.translatesAutoresizingMaskIntoConstraints = false
        image1.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblSubTitle.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius  = 14.0
        self.addSubview(cardView)
        
        cardView.addSubview(image1)
        cardView.addSubview(lblTitle)
        cardView.addSubview(lblSubTitle)
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12.0),
            cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6.0),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6.0),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12.0),
            
            //MARK: - Imageview
            image1.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor, constant: 12.0),
            image1.widthAnchor.constraint(equalToConstant: 100),
            image1.heightAnchor.constraint(equalToConstant: 100),
            image1.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
            //MARK: - Title
            lblTitle.leadingAnchor.constraint(equalTo: self.image1.trailingAnchor, constant: 12.0),
            lblTitle.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor,constant: -14.0),
            lblTitle.topAnchor.constraint(equalTo: self.image1.topAnchor, constant: 0.0),
            lblTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 21),
            
            //MARK: - SubTitle
            lblSubTitle.leadingAnchor.constraint(equalTo: self.image1.trailingAnchor, constant: 12.0),
            lblSubTitle.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor,constant:-14.0),
            lblSubTitle.topAnchor.constraint(equalTo: self.lblTitle.bottomAnchor, constant: 4.0),
            lblSubTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 21)
           
        ])
        image1.layer.cornerRadius = 12.0
        image1.clipsToBounds = true
        lblTitle.backgroundColor = .lightGray
        lblSubTitle.backgroundColor = .orange
        self.lblTitle.numberOfLines = 0
        self.lblSubTitle.numberOfLines = 0
   
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        intializeCard()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ProgramaticConstrainVC
class ProgramaticConstrainVC: UIViewController {

    //MARK: - UItableview
    let tableview  = UITableView()
    //var safeArea:UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // safeArea = self.view.layoutMarginsGuide
        self.view.backgroundColor = .brown

    }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        self.setupTableviewWithConstrain()
    }
    //MARK: - setupTableview
    func setupTableviewWithConstrain(){
        
         tableview.delegate = self
         tableview.dataSource = self
        //self  ==  classForCoder
         tableview.separatorStyle = .none
         tableview.register(CardTableviewCell.self, forCellReuseIdentifier: "CardTableviewCell")
        //MARK: - IMP Storyboarad Constrain  = false here
         tableview.translatesAutoresizingMaskIntoConstraints = false
         self.view.addSubview(tableview)
        
      //  tableview.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        
        //MARK: - Setup Layout Constrain Here
        NSLayoutConstraint.activate([
        
            tableview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 60),
            tableview.bottomAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
//MARK: -  UITableViewDelegate UITableViewDataSource
extension ProgramaticConstrainVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableviewCell", for: indexPath)as! CardTableviewCell
        //2,4,6,8,10,12 =  green else red
        cell.cardView.backgroundColor = indexPath.row % 2 == 0 ? .red : .green
        cell.image1.image = UIImage(named: "nature")
        cell.lblTitle.text  = "Apple Iphone \(4 + indexPath.row + 1)"
        cell.lblSubTitle.text  = "Apple Iphone Description Here ,Apple Iphone Description Here "
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
