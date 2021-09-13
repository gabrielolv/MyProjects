public with sharing class GetLoteriaResultController {

    public Static void getLastResult(){

        String      token       = '';
        String      product     = '';
        String[]    lastResult  = new String[]{};
        
        List<Loteria__mdt> lottery = new List<Loteria__mdt>([SELECT Id, DeveloperName, Token__c FROM Loteria__mdt LIMIT 1]);
        
        if(!lottery.isEmpty()) {
            for (Loteria__mdt l : lottery) {
                token   = l.Token__c;
                product = l.DeveloperName;
            }
            if(!String.isEmpty(token) && !String.isEmpty(product)){
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint('https://apiloterias.com.br/app/resultado?loteria='+product+'&token='+token+'&');
                request.setMethod('GET');
                HttpResponse response = http.send(request);
                if(response.getStatusCode() == 200){
                    Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    List<Object> dozens = (List<Object>) result.get('dezenas');
                    for(Object d : dozens){
                        String objDezenas = String.valueOf(d);
                        lastResult.add(objDezenas);
                    }
                }
            }
        }
        System.debug('Result >>>>>>>>>> ' + lastResult);
    }

    public static void getNewNumber(){
        
        Integer     randomNumber;
        Integer[]   newNumber               = new Integer[]{};  
        Integer[]   fullTable               = new Integer[]{1,2,3,4,5,6,10,11,15,16,20,21,22,23,24,25};
        Integer[]   primeNumbers            = new Integer[]{2,3,5,7,11,13,17,19,23};
        Integer[]   fibonacciNumbers        = new Integer[]{1,2,3,5,8,13,21};
        Integer[]   multipleOf3             = new Integer[]{3,6,9,12,15,18,21,24};

        for(Integer i = 0; newNumber.size() < 15; i++){
            randomNumber = Integer.valueOf(Math.floor(Math.random() * ((25-0)+1) + 1)); 
            
            if(newNumber.isEmpty() && (fullTable.contains(randomNumber) && fibonacciNumbers.contains(randomNumber) && multipleOf3.contains(randomNumber))){
                newNumber.add(randomNumber);
            }else{
                if(!newNumber.contains(randomNumber)){
                    newNumber.add(randomNumber);
                }           
            }
        }      
        for(Integer i = 0 ; i < newNumber.size() ; i ++) {
            for(integer j = i+1 ; j <= newNumber.size() -1 ; j ++ ){
              Integer x = 0 ;
              if(newNumber[i] >  newNumber[j]){
               x = newNumber[i];
               newNumber[i] = newNumber[j];
               newNumber[j] = x;
              }
            }
        } 
        System.debug('New Number >>>>>>>>>> ' + newNumber);
    }

}
