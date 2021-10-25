# Topic
This is my first topic.
## Topic level 2
This is my second topic.
### Topic level 3
This is my third topic.

[Google](www.google.com)
---
    pas

        
     begin

        WebShopSetup.Get();
        // TODO - new procedure for authorization
        AuthString := StrSubstNo(UserPwdTok, WebShopSetup."BackEnd User name", WebShopSetup."BackEnd Password");
        AuthString := Base64Convert.ToBase64(AuthString);
        //Headers := httpClient.DefaultRequestHeaders;
        httpClient.DefaultRequestHeaders().Add('Authorization', StrSubstNo('Basic %1', AuthString));
        //Headers.Add('Accept', '*/*');
        httpClient.Get(StrSubstNo(BackEndWebShopUrlLbl, WebShopSetup."Backend Web Service URL"), HttpResponseMessage);
        if HttpResponseMessage.IsSuccessStatusCode() then begin
            HttpResponseMessage.Content().ReadAs(ResponseText);
            ParseJson(ResponseText, TempItem);
            Page.Run(Page::"Item List", TempItem);
        end
        else
            Error(WebErrorMsg, HttpResponseMessage.HttpStatusCode());
    end;
[index](/help/index.md)