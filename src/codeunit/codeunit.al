codeunit 55101 Web
{

    trigger OnRun()
    var
        WebShopSetup: Record "Web Shop Setup";
        TempItem: Record Item temporary;
        Base64Convert: Codeunit "Base64 Convert";
        httpClient: httpClient;
        HttpResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        AuthString: Text;
        UserPwdTok: Label '%1:%2', Comment = '%1 is username, %2 is password';
        WebErrorMsg: Label 'Error occurred: %1', Comment = '%1 is http status code';
        BackEndWebShopUrlLbl: Label '%1/items?$top=3', Comment = '%1 is Web Shop url';
    //Headers: HttpHeaders;
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

    local procedure ParseJson(AuthString: Text; var TempItem: Record Item temporary)
    var
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        JsonArray: JsonArray;
        ItemJsonToken: JsonToken;
        ItemJsonObject: JsonObject;
    begin
        JsonObject.ReadFrom(AuthString);
        JsonObject.Get('value', JsonToken);
        JsonArray := JsonToken.AsArray();

        foreach ItemJsonToken in JsonArray do begin
            ItemJsonObject := ItemJsonToken.AsObject();

            TempItem.Init();
            TempItem."No." := CopyStr(GetFieldValue(ItemJsonObject, 'number').AsCode(), 1, MaxStrLen(TempItem."No."));
            TempItem.Description := CopyStr(GetFieldValue(ItemJsonObject, 'displayName').AsText(), 1, MaxStrLen(TempItem.Description));
            TempItem.Insert();
        end;
    end;

    local procedure GetFieldValue(var JsonObject: JsonObject; FieldName: Text): JsonValue
    var
        JsonToken: JsonToken;
    begin
        JsonObject.Get(FieldName, JsonToken);
        exit(JsonToken.AsValue());
    end;
}
