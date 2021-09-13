public class SysAdmin {
    
    public static void profileXML(){
        
        List<ObjectPermissions> objPermissions = new List<ObjectPermissions>();
    	List<FieldPermissions> fldPermissions = new List<FieldPermissions>();
        
        // Get all Custom Objects from ORG
        Set<String> customObjectsList = new Set<String>();
    
        List<EntityDefinition> customObjects = [SELECT QualifiedApiName, DeveloperName, IsCustomizable, NameSpacePrefix FROM EntityDefinition WHERE IsCustomSetting = false AND QualifiedApiName LIKE '%__c' Order by QualifiedApiName];
    
        for(EntityDefinition customObject : customObjects){
            customObjectsList.add(customObject.QualifiedApiName);
        }
    
        List<ObjectPermissions> newobjectPermissionsList = new List<ObjectPermissions>();
    
        for(ObjectPermissions obj : [SELECT Id, SObjectType, PermissionsRead, PermissionsEdit 
                                     FROM ObjectPermissions WHERE SObjectType in : customObjectsList
                                     AND (PermissionsRead = false or PermissionsEdit = false)
                                     AND parentId IN ( SELECT id FROM permissionset WHERE PermissionSet.Profile.Name = 'System Administrator')
                                    ]){
            if(!obj.PermissionsRead || !obj.PermissionsEdit){
                obj.PermissionsRead = true;
                obj.PermissionsEdit = true;
            }
            
            objPermissions.add(obj);
        }
    
        for(FieldPermissions field : [SELECT Parent.Profile.Name, Parent.Label, Parent.IsOwnedByProfile, SobjectType, Field, PermissionsEdit, PermissionsRead 
                                      FROM FieldPermissions WHERE Parent.Profile.Name= 'System Administrator' 
                                      AND (PermissionsEdit = false OR PermissionsRead = false) ORDER BY Parent.Profile.Name, Parent.Label, SobjectType, Field 
        ]){
            String objType = String.valueOf(field.SObjectType);
            Boolean customObj = objType.contains('__c');
            if(customObj && (!field.PermissionsRead || !field.PermissionsEdit)){
                field.PermissionsRead = true;
                field.PermissionsEdit = true;                
            }
            
            fldPermissions.add(field);
        }
        
        if(!objPermissions.isEmpty()){
            update objPermissions;
        }
        if(!fldPermissions.isEmpty()){
            update fldPermissions;
        }
    }
}