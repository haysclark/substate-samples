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

package;

import openfl.display.Sprite;
import substate.SubStateMachine;
import substate.ISubStateMachine;
import QuakeStates;

class Main extends Sprite {

	public function new () {
		
		super ();

        trace("--> Create a basic (sub) state machine.");
        var stateMachine = createSubStateMachine();

        trace("--> Add our \"Quake\" states to demo Hierarchical State Machine basics");
        addQuakeStates(stateMachine);
        trace("");

        trace("--> Setting our initial state: " + stateMachine.currentState);
        stateMachine.initialState = IdleState.ID;
        trace("");

        trace("--> Awesome!  So now were are in the \"Idle\" state.");
        trace("--> Lets do something more exciting... lets Attack!");
        stateMachine.doTransition(AttackState.ID);
        trace("");
        trace("--> Wow! A lot happened there! Lets run through what happened.");
        trace("----> First, we exit IDLE state.");
        trace("----> Then, we enter the Attack state, and the state determines to change the State immediately to \"Smash Attack\"");
        trace("----> However; you will see that we first enter \"Melee Attack\".  This is because the \"Smash\" state is a CHILD of \"Melee Attack\",");
        trace("----> and \"Melee Attack\" is a child of \"Attack\".  We enter the parent states FIRST, before entering the child state.");
        trace("----> It's important to note that we do NOT exit the \"Attack\" state!");
        trace("");
        trace("--> Lets pretend the enemy now attacks you and... crap.  He kills us!!!");
        trace("--> So now the state gets set to the \"Die\" state.");
        stateMachine.doTransition(DieState.ID);
        trace("");
        trace("--> Now you can see that we exit the Hierarch of states from top to bottom.");
        trace("--> Once all the states have exited we enter the \"Die\" state.");
        trace("--> And... scene.");
        trace("");
        trace("--> Hopefully that helps illustrate the power of a Hierarchical State Machine");
    }

    private function createSubStateMachine():ISubStateMachine {
        var stateMachine = new SubStateMachine();
        stateMachine.init();
        return stateMachine;
    }

    /**
	 * It's also possible to create hierarchical state machines using the argument "parent" in the addState method
	 * This example shows the creation of a hierarchical state machine for the monster of a game
	 *(Its a simplified version of the state machine used to control the AI in the original Quake game)
	 **/
    private function addQuakeStates(stateMachine:ISubStateMachine):Void {
        var idle = new IdleState();
        idle.setStateMachine(stateMachine);
        stateMachine.addState(idle);

        var attack = new AttackState();
        attack.setStateMachine(stateMachine);
        stateMachine.addState(attack);

        var meleeAttack = new MeleeAttackState();
        meleeAttack.setStateMachine(stateMachine);
        stateMachine.addState(meleeAttack);

        var smash = new SmashState();
        smash.setStateMachine(stateMachine);
        stateMachine.addState(smash);

        var punch = new PunchState();
        punch.setStateMachine(stateMachine);
        stateMachine.addState(punch);

        var missleAttack = new MissleAttackState();
        missleAttack.setStateMachine(stateMachine);
        stateMachine.addState(missleAttack);

        var die = new DieState();
        die.setStateMachine(stateMachine);
        stateMachine.addState(die);
    }
}
