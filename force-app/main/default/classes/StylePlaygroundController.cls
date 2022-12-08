public with sharing class StylePlaygroundController {
    
    @AuraEnabled
    public static void passingMaps(Map<Id, Integer> mapInput){
        System.debug(mapInput);
    }
}
