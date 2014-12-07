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
    def to_ast()
        self.fsm
        @machine
    end
}

fsm : state* EOF;
state : initial? 'state' id { @current_state = @machine.add_state($id.text, ($initial.text == 'initial')) } '{' transition* '}' ;
initial : 'initial' ;
transition : input ('/' action )? ( '->' id )? ';' { @machine.add_transition(@current_state.name, $id.text, $input.text, $action.text) };
id : NAME ;
input : NAME ;
action : NAME ;
NAME : ('a'..'z'|'A'..'Z')+ ;
WS : ( '\t' | ' ' | '\r' | '\f' )+ {$channel = HIDDEN;};
