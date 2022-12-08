public with sharing class HelloWorldController {
    private Timesheet__c timesheet;

    public HelloWorldController(ApexPages.StandardController controller) {
        timesheet = [SELECT Name
                        FROM Timesheet__c
                        WHERE Id = :controller.getId()];
    }

    public String getWelcomeMessage() {
        return 'Welcome to Salesforce! Your timesheet number is: ' + timesheet.Name;
    }

    public List<String> getStringCollection() {
        List<String> returnStrings = new List<String>();
        returnStrings.add('One');
        returnStrings.add('Two');
        returnStrings.add('Three');
        returnStrings.add('Four');

        return returnStrings;
    }
}