/****
* 
*    substate
*    =================================
*    A Single Hierarchical State Machine
* 
*               |_
*         _____|~ |______ ,.
*        ( --  subSTATE  `+|
*      ~~~~~~~~~~~~~~~~~~~~~~~
* 
* Copyright (c) 2014 Infinite Descent. All rights reserved.
* 
* Redistribution and use in source and binary forms, with or without modification, are
* permitted provided that the following conditions are met:
* 
*   1. Redistributions of source code must retain the above copyright notice, this list of
*      conditions and the following disclaimer.
* 
*   2. Redistributions in binary form must reproduce the above copyright notice, this list
*      of conditions and the following disclaimer in the documentation and/or other materials
*      provided with the distribution.
* 
* THIS SOFTWARE IS PROVIDED BY INFINITE DESCENT ``AS IS'' AND ANY EXPRESS OR IMPLIED
* WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
* FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL INFINITE DESCENT OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
* ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
* ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* 
* The views and conclusions contained in the software and documentation are those of the
* authors and should not be interpreted as representing official policies, either expressed
* or implied, of Infinite Descent.
****/

package ;

import substate.ISubStateMachine;
import substate.SubStateMachine;
import substate.IState;

/**
 * SubState does NOT define a "State" class, so that you can!
 * Simply use the IState interface.
 **/
class State implements IState {
    //----------------------------------
    //  vars
    //----------------------------------
    // a reference to the state machine
    private var _stateMachine:ISubStateMachine;

    //--------------------------------------------------------------------------
    //
    //  CONSTRUCTOR
    //
    //--------------------------------------------------------------------------
    public function new(uid:String) {
        name = uid;
        parentName = SubStateMachine.NO_PARENT; // or use "", but NOT null
        froms = [];
    }

    public function setStateMachine(stateMachine:ISubStateMachine):Void {
        _stateMachine = stateMachine;
    }

    //----------------------------------
    //  IState
    //----------------------------------
    /** the state's UID **/
    public var name(default, null):String;

    /** the parent state's UID (optional) **/
    public var parentName(default, null):String;

    /**
     * the state UIDs which can transition to this state
	 * defaults to None.  Use WILDCARD to allow all states
	 **/
    public var froms(default, null):Array<String>;

    //----------------------------------
    //  IEnter
    //----------------------------------
    public function enter(toState:String, fromState:String, currentState:String):Void {
        trace("Entering state: " + name);
    }

    //----------------------------------
    //  IExit
    //----------------------------------
    public function exit(fromState:String, toState:String, currentState:String = null):Void {
        trace("Exiting state: " + name);
    }
}

/**
 * All the Quake States
 **/
class IdleState extends State {
    //----------------------------------
    //  CONTS
    //----------------------------------
    public static inline var ID:String = "idle"; // States UID

    //--------------------------------------------------------------------------
    //
    //  CONSTRUCTOR
    //
    //--------------------------------------------------------------------------
    public function new() {
        super(ID);
        froms = [
            AttackState.ID
        ];
    }
}

class AttackState extends State {
    //----------------------------------
    //  CONTS
    //----------------------------------
    public static inline var ID:String = "attack"; // States UID

    //--------------------------------------------------------------------------
    //
    //  CONSTRUCTOR
    //
    //--------------------------------------------------------------------------
    public function new() {
        super(ID);
        froms = [
            IdleState.ID
        ];
    }

    //----------------------------------
    //  IEnter
    //----------------------------------
    override public function enter(toState:String, fromState:String, currentState:String):Void {
        super.enter(toState, fromState, currentState); // to trace state

        // Lets pretend we were finding a target near us...
        trace("The enemy is close! Smash Attack!");
        _stateMachine.doTransition(SmashState.ID);
    }
}

class MeleeAttackState extends State {
    //----------------------------------
    //  CONTS
    //----------------------------------
    public static inline var ID:String = "melee attack"; // States UID

    //--------------------------------------------------------------------------
    //
    //  CONSTRUCTOR
    //
    //--------------------------------------------------------------------------
    public function new() {
        super(ID);
        parentName = AttackState.ID;
        froms = [
            AttackState.ID
        ];
    }
}

class SmashState extends State {
    //----------------------------------
    //  CONTS
    //----------------------------------
    public static inline var ID:String = "smash"; // States UID

    //--------------------------------------------------------------------------
    //
    //  CONSTRUCTOR
    //
    //--------------------------------------------------------------------------
    public function new() {
        super(ID);
        parentName = MeleeAttackState.ID;
        // froms are not set and are inherited from parents
    }
}

class PunchState extends State {
    //----------------------------------
    //  CONTS
    //----------------------------------
    public static inline var ID:String = "punch"; // States UID

    //--------------------------------------------------------------------------
    //
    //  CONSTRUCTOR
    //
    //--------------------------------------------------------------------------
    public function new() {
        super(ID);
        parentName = MeleeAttackState.ID;
        // froms are not set and are inherited from parents
    }
}

class MissleAttackState extends State {
    //----------------------------------
    //  CONTS
    //----------------------------------
    public static inline var ID:String = "missle attack"; // States UID

    //--------------------------------------------------------------------------
    //
    //  CONSTRUCTOR
    //
    //--------------------------------------------------------------------------
    public function new() {
        super(ID);
        froms = [
            AttackState.ID
        ];
    }
}

class DieState extends State {
    //----------------------------------
    //  CONTS
    //----------------------------------
    public static inline var ID:String = "die"; // States UID

    //--------------------------------------------------------------------------
    //
    //  CONSTRUCTOR
    //
    //--------------------------------------------------------------------------
    public function new() {
        super(ID);
        froms = [
            AttackState.ID,
            IdleState.ID
        ];
    }
}





