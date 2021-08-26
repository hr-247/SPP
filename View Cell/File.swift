//
//  File.swift
//  SPP
//
//  Created by sanganan on 2/26/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import Foundation
 var sugListArr = [SuggestionList]()
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "detailSec3CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "detailSec3CollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource =  self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailSec3CollectionViewCell", for: indexPath) as! detailSec3CollectionViewCell
        cell.hdngLbl.text = sugListArr[indexPath.row].agenda_related_title
        cell.imgView.sd_setImage(with: URL(string: sugListArr[indexPath.row].agenda_related_image!), placeholderImage: UIImage(named: "male_avtar"))
        let strDate = AppUtils.timestampToDate(timeStamp: Double(sugListArr[indexPath.row].agenda_related_start_date!))
        cell.lBl1.text = strDate
    
    return cell
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
