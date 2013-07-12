function tabUrl(title,url){
    var exist = $('#globaltab').tabs("exists",title);
    if(!exist){
        $('#globaltab').tabs('add',{
            title:title,
            href:url,
            closable:true,
            border:false
        });
    }else{
        $('#globaltab').tabs("select",title);
    }
}