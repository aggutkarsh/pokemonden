//
//  Mapper+Protocol.swift
//  PokémonDen
//
//  Created by Utkarsh Agrawal on 26/12/22.
//

import Foundation

protocol BaseMappper {
    func fromDataToDomainModel(dataModel: BaseDataModel) -> BaseDomainModel?
}
