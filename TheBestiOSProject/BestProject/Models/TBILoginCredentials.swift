//
//  TBILoginCredentials.swift
//  TheBestiOSProject
//
//  Created by Sanooj on 17/06/2018.
//  Copyright © 2018 DCore. All rights reserved.
//

import Foundation

enum TBIValueChangeType: String
{
    case New
    case Old
    case Unchanged
}

protocol TBIValueChangePropagationDelegate: class
{
    func valueOf<Source,Element,Change>(
        element:Element,
        fromSource source:Source,
        didChange change: [TBIValueChangeType : Change]
    )
}

class TBILoginCredentials: Equatable
{
    static func == (lhs: TBILoginCredentials, rhs: TBILoginCredentials) -> Bool {
        return
            { (lhs: TBILoginCredentials, rhs: TBILoginCredentials) -> Bool in
                
                if lhs._password == rhs._password &&
                    lhs.userName == rhs._userName
                {
                    return true
                }
                
                return false
                
            }(lhs,rhs)
    }
    
    ///private vars
    private let _userName: String
    private let _password: String
    
    ///public accessors
    var userName: String
    {
        get
        {
            return self._userName
        }
    }
    
    var password: String
    {
        get
        {
            return self._password
        }
    }
    
    ///public init
    init(userName:String, andPassword password:String)
    {
        self._userName =
        userName
        
        self._password =
        password
    }
}

// TODO: This is a state change info -- Need to Fix
protocol TBILoginConfiguration
{
    ///read only acessor
    var shouldRememberPassword:Bool {get}
}


//Screen Behaviour
/**
 1. every property of every Ui component is abstracted to a variable
 2. each screen has its own behaviours
 3. state chanage is also abstracted
 4. state chnage should be compatible with Uistaterestoration Api
 */

/**
 * Steps
 1. Creata a class/struct/protocol that has all properties that the UI would need
 a. you could also segregate controls and make individual classed
 
 */

///

///
/// `Base Configurator` class
///
class TBIBaseViewConfigurator
{
    weak var delgate: TBIValueChangePropagationDelegate? =
    nil
}


class TBILoginScreenViewConfigurator: TBIBaseViewConfigurator
{
    var usernameFieldText: String = ""
    {
        willSet
        {
            //propagate the change
        }
    }
    
    var passwordFieldText: String = ""
    {
        willSet
        {
            //propagate the change
        }
    }
}

