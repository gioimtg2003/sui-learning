/*
/// Module: move
module ticket_app::move;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

module ticket_app::ticket{
    
    use std::string;
    public struct Ticket has key {
        id: UID,
        eventName: Option<string::String>,
        ticketNumber: u64,
        isUsed: bool
    }

    public fun createTicket(ticketNumber: u64, eventName: vector<u8>, ctx: &mut TxContext) {

        let mut currentNameEvent = string::utf8(eventName);
        if(string::is_empty(&currentNameEvent)){
            currentNameEvent = string::utf8(b"No Name");
        };

        transfer::transfer(Ticket{
            id: object::new(ctx),
            eventName: option::some(currentNameEvent),
            ticketNumber: ticketNumber,
            isUsed: false,
        },tx_context::sender(ctx));
    }

    public fun checkIn (ticket: &mut Ticket){
        ticket.isUsed = true;
    }

}


