import UIKit

extension UICollectionView {
    static var compositionalLayout: UICollectionViewCompositionalLayout = {
        let compositionalLayout = UICollectionViewCompositionalLayout { (sectionId, _) -> NSCollectionLayoutSection? in
            
            if(sectionId == 0) {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.93), heightDimension: .absolute(210)), subitems: [item])
                group.contentInsets.trailing = 6
                group.contentInsets.leading = 6
                
                let section = NSCollectionLayoutSection(group: group)
//                section.contentInsets.leading = 5
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            } else if(sectionId == 1) {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(140)), subitems: [item])
                group.contentInsets.trailing = 10
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 5
                section.contentInsets.leading = 5

                return section
            }
            
            else if(sectionId == 2) {
               // watch trailer
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), subitems: [item])
                group.contentInsets.trailing = 10
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 5
                section.contentInsets.leading = 5

                return section
            }
            
            
            else if(sectionId == 3) {
                // cast title cell
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)), subitems: [item])
                group.contentInsets.trailing = 10
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 5
                section.contentInsets.leading = 5
                section.orthogonalScrollingBehavior = .paging
                return section
            }
            else if(sectionId == 4) {
                // cast cell
                let fractionWidth: CGFloat = 0.32
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(fractionWidth), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                group.contentInsets.trailing = 10
                group.interItemSpacing = .fixed(5)
                group.contentInsets.bottom = 10
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 10
                section.contentInsets.leading = 13
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            }
            else if(sectionId == 5){
                let fractionWidth: CGFloat = 1
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(fractionWidth), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), subitems: [item])
                group.contentInsets.trailing = 10
                group.interItemSpacing = .fixed(5)
                group.contentInsets.bottom = 10
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 10
                section.contentInsets.leading = 13
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            }
            else {
                let fractionWidth: CGFloat = 0.8
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(fractionWidth), heightDimension: .absolute(260)), subitems: [item])
                group.contentInsets.trailing = 10
                group.interItemSpacing = .fixed(5)
                group.contentInsets.bottom = 10
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 10
                section.contentInsets.leading = 13
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            }
        }
        return compositionalLayout
    }()
}
