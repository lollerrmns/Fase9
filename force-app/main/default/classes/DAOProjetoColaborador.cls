/**
 * 	@testClass
 *	@description DAO para objeto: Projeto_Colaborador__c
 *	@author Elias Melo - atile.branding
 *	@date 2022-01-05
*/
public class DAOProjetoColaborador {
    
/**
 *	@description retorna a consulta de Projeto x Colaborador identificado por Conta
 *	@param pLista List<Account>
 *	@return List<Projeto_Colaborador__c>
 *	@author Elias Melo - atile.branding
 *	@date 2022-01-05
*/
	public static List<Projeto_Colaborador__c> getColaboradorByConta(List<Account> pLista){
        return [SELECT Id, Name, Colaborador__c
                FROM Projeto_Colaborador__c 
                WHERE Colaborador__c IN: pLista];
	}
    
/**
 *	@description retorna a consulta de Projeto x Colaborador identificado por Conta
 *	@param pIdProjeto String
 *	@return List<Projeto_Colaborador__c>
 *	@author Elias Melo - atile.branding
 *	@date 2022-02-20
*/

    public static List<Projeto_Colaborador__c> getColaboradorByIdProjeto(String pIdProjeto){
        return [SELECT Id,Name,Colaborador__c FROM Projeto_Colaborador__c WHERE Projeto__c = :pIdProjeto];
    }
}