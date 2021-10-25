page 55100 "Web Shop Setup Page"
{

    Caption = 'Web Shop Setup Page';
    PageType = Card;
    SourceTable = "Web Shop Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;
    AdditionalSearchTerms = 'Web Shop';

    layout
    {
        area(content)
        {
            group(BackEndWebService)
            {
                field("BackEnd Web Service URL"; Rec."BackEnd Web Service URL")
                {
                    ToolTip = 'Specifies the value of the BackEnd Web Service URL field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                group(BackEndServiceCredentials)
                {
                    field("BackEnd User name"; Rec."BackEnd User name")
                    {
                        ToolTip = 'Specifies the value of the BackEnd User name field.';
                        ApplicationArea = All;
                    }
                    field("BackEnd Password"; Rec."BackEnd Password")
                    {
                        ToolTip = 'Specifies the value of the BackEnd Password field.';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        if not rec.Get() then begin
            rec.Init();
            rec."BackEnd Web Service URL" := 'https://bc-webshop.westeurope.cloudapp.azure.com:7048/bc/api/v1.0/companies(3adc449e-8621-ec11-bb76-000d3a29933c)';
            rec.Insert();
        end;
    end;
}
