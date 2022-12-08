@isTest
private with sharing class TimesheetRejectionCounterTest {

    @TestSetup
    static void createTestData() {
        Account testAccount = new Account();
        testAccount.Name = 'Account Name';
        insert testAccount;

        Contact employee = new Contact();
        employee.LastName = 'Doe';
        employee.AccountId = testAccount.Id;
        insert employee;

        Timesheet__c testTimesheet = new Timesheet__c();
        testTimesheet.Employee__c = employee.Id;
        testTimesheet.Status__c = 'Draft';
        testTimesheet.Number_of_Times_Rejected__c = 0;
        insert testTimesheet;
    }

    @isTest
    static void methodUnderTest_given_should() {

    }

    @isTest
    static void updateTimesRejectedOnRejection_givenRejectedTimesheets_shouldIncrementCount() {
        Timesheet__c testTimesheet = [SELECT Status__c
                                        FROM Timesheet__c
                                        LIMIT 1];

        Test.startTest();

        testTimesheet.Status__c = 'Rejected';
        update testTimesheet;

        Test.stopTest();

        testTimesheet = [SELECT Number_of_Times_Rejected__c
                            FROM Timesheet__c
                            WHERE Id = :testTimesheet.Id
                            LIMIT 1];

        System.assertEquals(1, testTimesheet.Number_of_Times_Rejected__c, 'The number of times rejected should have been incremented.');
    }

    @isTest
    static void updateTimesRejectedOnRejection_givenApprovedTimesheet_shouldNotIncrementCount() {
        Timesheet__c testTimesheet = [SELECT Status__c
                                        FROM Timesheet__c
                                        LIMIT 1];
        
        Test.startTest();

        testTimesheet.Status__c = 'Approved';
        update testTimesheet;

        Test.stopTest();

        testTimesheet = [SELECT Number_of_Times_Rejected__c
                            FROM Timesheet__c
                            WHERE Id = :testTimesheet.Id
                            LIMIT 1];

        System.assertNotEquals(1, testTimesheet.Number_of_Times_Rejected__c, 'The number of times rejected should not have been incremented.');
    }

    @isTest
    static void updateTimesRejectedOnRejection_givenNullCounter_shouldSetCounterToZero() {
        Timesheet__c testTimesheet = [SELECT Status__c, Number_of_Times_Rejected__c
                                        FROM Timesheet__c
                                        LIMIT 1];
        
        Test.startTest();

        testTimesheet.Number_of_Times_Rejected__c = null;
        testTimesheet.Status__c = 'Rejected';
        update testTimesheet;

        Test.stopTest();

        testTimesheet = [SELECT Number_of_Times_Rejected__c
                            FROM Timesheet__c
                            WHERE Id = :testTimesheet.Id
                            LIMIT 1];

        System.assertEquals(1, testTimesheet.Number_of_Times_Rejected__c, 'The null number of times rejected should have been supported.');
    }

    private static Timesheet__c createTimesheet(String status, Id employeeId) {
        Timesheet__c testTimesheet = new Timesheet__c();
        testTimesheet.Employee__c = employeeId;
        testTimesheet.Status__c = status;

        return testTimesheet;
    }
}