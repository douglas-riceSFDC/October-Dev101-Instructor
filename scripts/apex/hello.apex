public static void queryBaseExamples() {
    List<Project__c> projects = [
        SELECT Name, Owner.Name,
            (SELECT Id, Project__c
                FROM Project_Assignments__r)
        FROM Project__c
    ];

    List<Project_Assignment__c> projects = [
        SELECT Name, Project__r.Name,
            FROM Project_Assignment__c
    ];

    for(Project__c p : projects) {
        for(Project_Assignment__c pa: p.Project_Assignments__r) {
            System.debug(p.Owner.Name + ' - ' + pa.Id + ' - ' + pa.Project__c);
        }
    }

    List<Account> accounts = [SELECT Id FROM Account];
    List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId IN :accounts];

    System.debug(contacts);

    List<Account> accounts = [SELECT Id, Name,
                                    (SELECT FirstName, LastName
                                    FROM Contacts)
                                FROM Account];

    for(Account a : accounts) {
        System.debug(a.Contacts);
    }
}

    String valueFromUser = 'New Value \' OR Id != null \'';

    valueFromUser = String.escapeSingleQuotes(valueFromUser);
    String query = 'SELECT Id, ContactEmail FROM Case WHERE Subject = \'' + valueFromUser;




    String baseQuery = 'SELECT Id, , ContactEmail FROM Case';

    if(day == 'Saturday') {
        baseQuery += ' WHERE Subject = \'Problem\''; 
       
    } else {
        baseQuery += ' WHERE Subject IN {\'Value One\', \'Value Two\'}';
    }

    System.debug(Database.query(baseQuery));



public static void queryExampleOne() {

    List<Case> cases = [SELECT Id, Subject, ContactEmail
                            FROM Case];


    System.debug(cases);
    
    for(Case c : cases) {
        System.debug(c.Status);
    }
}

public static void queryExampleTwo() {
    List<Lead> leads = [SELECT Id, Email, Owner.Name, Owner.Email, Company, OwnerId
                            FROM Lead
                        ];
    
    for(Lead l : leads) {
        System.debug('----');
        System.debug(l.Id);
        System.debug(l.Email);
        System.debug(l.Owner.Name);
        System.debug(l.Owner.Email);
        System.debug(l.Company);
        System.debug(l.OwnerId);
    }
}

public static void queryExampleThree() {

    List<Account> accounts = [SELECT Id
                                FROM Account
                                WHERE Industry = 'Banking'
                                    AND Type = 'Analyst'];
    
    System.debug(accounts.size());
}

public static void queryExampleFour() {

    List<Opportunity> opps = [SELECT Id, Name, Amount, AccountId,
                    (SELECT ListPrice, Quantity
                        FROM OpportunityLineItems)
                    FROM Opportunity
                    WHERE Amount > 1000];

    System.debug(opps[0].OpportunityLineItems);
}

public static void queryExampleFive() {

    System.debug([SELECT QuoteId, ListPrice, UnitPrice
                    FROM QuoteLineItem]);

    for(QuoteLineItem qli : quotes) {
        if(qli.ListPrice > qli.UnitPrice) {
            newList.add(qli);
        }
    }

    // do what I need to with newList instead

                    
}

public static void queryExampleSix() {

    List<Contact> queriedContacts = [SELECT Id, FirstName, LastName, LastModifiedDate
                                        FROM Contact];

    List<Id> contactIds = new List<Id>();
    for(Contact c : queriedContacts) {
        contactIds.add(c.Id);
    }

    System.debug([SELECT Id, Employee__c, Employee__r.Name, Project__c, Project__r.Start_Date__c
                    FROM Project_Assignment__c
                    WHERE Employee__c IN :contactIds
                        AND Project__r.Start_Date__c > :Date.today()]);
}

