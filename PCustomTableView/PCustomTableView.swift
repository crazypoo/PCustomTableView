//
//  PCustomTableView.swift
//  PCustomTableView
//
//  Created by 邓杰豪 on 2016/9/18.
//  Copyright © 2016年 邓杰豪. All rights reserved.
//

import UIKit

class PCustomTableView: UITableView {

    var appearanceSpeed:CGFloat?

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.appearanceSpeed = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        super.setContentOffset(contentOffset, animated: true)
        updateVisibleCells()
    }

    func updateVisibleCells()
    {
        for indexPath in self.indexPathsForVisibleRows!
        {
            let originRowRect = self.rectForRow(at: indexPath)
            let rowRect = self.superview?.convert(self.rectForRow(at: indexPath), from: self)
            let cell = self.cellForRow(at: indexPath)
            updateOriginXForCell(cell: cell!, cellRect: rowRect!, originCellRect: originRowRect)
        }
    }

    func updateOriginXForCell(cell:UITableViewCell,cellRect:CGRect,originCellRect:CGRect)
    {
        var newFrame = cell.contentView.frame
        let selfHeight = self.frame.size.height
        let cellWidth = cell.contentView.frame.size.width
        let cellHeight = cell.contentView.frame.size.height
        let cellOriginY = cellRect.origin.y

        var newOriginX = (cellOriginY - selfHeight) / (selfHeight - cellHeight / self.appearanceSpeed! - selfHeight) * -cellWidth + cellWidth

        if newOriginX > cellWidth
        {
            newOriginX = cellWidth
        }
        else if newOriginX < 0 || self.frame.contains(originCellRect.origin)
        {
            newOriginX = 0
        }

        newFrame.origin.x = newOriginX
        cell.contentView.frame = newFrame
    }
}
