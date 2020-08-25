public with sharing class loopUsingList {
    public static void loopUsingList() {

        for(List<Account> a: [SELECT Id,Name FROM Account]){
            System.debug('LISTA DE CONTAS ' + a.size());
        }
        
        for(Account acc: [SELECT Id,Name FROM Account]){
            System.debug('QUANTIDADES DE CONTAS ' + acc);
        }
    }
}
