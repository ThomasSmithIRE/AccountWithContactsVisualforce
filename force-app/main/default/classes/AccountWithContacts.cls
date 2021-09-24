public class AccountWithContacts{

    public Contact sob { get; set; } 
    public List<wrapperSob> contactList {get; set;}
    
    public AccountWithContacts() {
        sob = [select AccountId from Contact limit 1];   
    }   
    
    public void refresh() { 
        contactList = null;  // set contactList to null so that the VF page rerenders
    }
    
    public List<wrapperSob> getContacts() { 
        if(contactList == null) {
            contactList = new List<wrapperSob>();
            for(Contact c: [select Name
                            from Contact 
                            where AccountId = :sob.AccountId  
                            order by Name
                            limit 10]) {
                contactList.add(new wrapperSob(c));
            }
        }
        return contactList;
    }

    public class wrapperSob {
        public Contact con { get; set; }

        public wrapperSob(Contact c) {
            con = c;
        }
    }
}