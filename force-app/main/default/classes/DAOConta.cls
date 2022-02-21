public with sharing class DAOConta {
    public static List<Account> getAccountByRecordType(String idRecordType){
        return [SELECT Id,Name FROM Account WHERE Ativo__c = true AND RecordTypeId = :idRecordType];
    }
    public static List<Account> getAccountByIds(List<String> ids){
        return [SELECT Id,Name FROM Account WHERE Id = :ids];
    }
}
