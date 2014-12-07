grammar FSML;

options {
    language=Ruby;
}

@header {
}

@init {
    @machine = StateMachine.new
}

@members {
    def ast()
        self.fsm
        @machine
    end
}

fsm : state* EOF;
state : initial? 'state' id '{' transition* '}' { @machine.add_state($id.text, ($initial.text == 'initial')) } ;
initial : 'initial' ;
transition : input ('/' action )? ( '->' id )? ';' ;
id : NAME ;
input : NAME ;
action : NAME ;
NAME : ('a'..'z'|'A'..'Z')+ ;
WS : ( '\t' | ' ' | '\r' | '\n'| '\u000C' )+ {$channel = HIDDEN;};