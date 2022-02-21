public with sharing class ControllerFaseNove {
    @AuraEnabled(cacheable = true)
    public static String getProjectId(String idd){
        return idd;
    }
    @AuraEnabled(cacheable = true)
    public static List<Account> listaContasAtivas(String idd){
        try {
            String idRecordType = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Colaborador').getRecordTypeId();
            List<Account> a = DAOConta.getAccountByRecordType(idRecordType);
            System.debug('Lista Contas Ativas'+idd);
            System.debug(a);
            return a;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable = true)
    public static List<Account> listaContasDoProjeto(String idd){
        try {
            List<Projeto_Colaborador__c> colab = DAOProjetoColaborador.getColaboradorByIdProjeto(idd);
            List<String>  colaboradores = new List<String>();
            for (Projeto_Colaborador__c cc : colab) {
                colaboradores.add(cc.Colaborador__c+'');
            }
            List<Account> a = DAOConta.getAccountByIds(colaboradores);
            System.debug('Lista contas do Projeto'+idd);
            System.debug(a);
            return a;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void gravar(List<String> pListId,String pIdProjeto){
        List<Projeto_Colaborador__c> ini = DAOProjetoColaborador.getColaboradorByIdProjeto(pIdProjeto);
        List<Projeto_Colaborador__c> toUpsert = new List<Projeto_Colaborador__c>();
        List<Projeto_Colaborador__c> toDelete = new List<Projeto_Colaborador__c>();
        System.debug('Lista contas do Projeto'+ini);
//Percorre a lista e verifica se um item precisa ser Deletado
        for (Projeto_Colaborador__c i : ini) { if(!contem(pListId, i.id)){toDelete.add(i);} else {toUpsert.add(i);}  }
//Percorre a lista e verifica se um item precisa ser Inserido
        for (String i : pListId) { if(!contem(toUpsert, i)){toUpsert.add(new Projeto_Colaborador__c(Colaborador__c = i,Projeto__c = pIdProjeto));}  }
        System.debug('Lista contas do Insert'+toUpsert);
        System.debug('Lista contas do Delete'+toDelete);
        delete toDelete;

        upsert toUpsert;
    }
    /* 
    * @description Metodo utilizado para auxiliar na verificação se a lista contem um item específico
    * @param pLista List<Projeto_Colaborador__c>
    * @param pTexto String
    * @return Boolean
    * @author Elias Melo - atile.branding
    * @date 20/02/2022
    */
    public static Boolean contem(List<Projeto_Colaborador__c> pLista,String pTexto){
        for (Projeto_Colaborador__c p : pLista) {
            if (p.id == pTexto) {
                return true;
            }            
        }
        return false;
    }
    /* 
    * @description Metodo utilizado para auxiliar na verificação se a lista contem um item específico
    * @param pLista List<String>
    * @param pTexto String
    * @return Boolean
    * @author Elias Melo - atile.branding
    * @date 20/02/2022
    */
    public static Boolean contem(List<String> pLista,String pTexto){
        for (String p : pLista) {
            if (p == pTexto) {
                return true;
            }            
        }
        return false;
    }
}
