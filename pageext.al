pageextension 55101 CustomerListExt extends "Customer List"
{
    actions
    {
        addfirst(processing)
        {
            action(GetWebServiceItemList)
            {
                ApplicationArea = all;
                Caption = 'Get Web Service Item List';
                Promoted = true;
                Image = Web;
                PromotedCategory = Process;
                ToolTip = 'Exec the Web get service item';
                RunObject = codeunit Web;
            }
        }
    }
}