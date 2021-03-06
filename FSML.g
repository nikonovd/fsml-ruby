grammar FSML;

options {
    language=Ruby;
}

@header {
    require 'exceptions'
}

@init {
    @machine = StateMachine.new
}

@members {
    def to_ast()
        self.fsm
        @machine
    end

    def error_message(e)
        raise Exceptions::ParseException
    end
}

fsm : state* EOF;
state : initial? 'state' id { @current_state = @machine.add_state($id.text, ($initial.text == 'initial')) } '{' transition* '}' ;
initial : 'initial' ;
transition : input ('/' action )? ( '->' id )? ';' { @current_state.add_transition($id.text, $input.text, $action.text) };
id : NAME ;
input : NAME ;
action : NAME ;
NAME : ('a'..'z'|'A'..'Z')+ ;
WS : ( '\t' | ' ' | '\r' | '\f' | '\n' )+ {$channel = HIDDEN;};
