public with sharing class Prime{
    public void check(Integer n){
    //Display dis = PlatformUI.create
      integer i=0;
      integer m=0;
      integer flag=0;
      
      m = n/2;
      if(n==0 || n==1 || m ==1){
   			 system.debug(n + ' ' + 'is not prime number'); 
       }
 else{
   for(i=2;i<=m;i++){    
    if(Math.mod(n,i) ==0){    
     system.debug(n + ' ' + 'is not prime number');
     flag=1;    
     break;    
    }    
   }
   if(flag==0)  { 
   	system.debug(n + ' ' + 'is a prime number');    }
 }
    }
}