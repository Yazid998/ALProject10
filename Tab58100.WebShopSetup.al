table 55100 "Web Shop Setup"
{
    Caption = 'Web Shop Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "BackEnd Web Service URL"; Text[250])
        {
            Caption = 'BackEnd Web Service URL';
            DataClassification = CustomerContent;
        }
        field(3; "BackEnd User name"; Text[100])
        {
            Caption = 'BackEnd User name';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(4; "BackEnd Password"; Text[100])
        {
            Caption = 'BackEnd Password';
            DataClassification = EndUserIdentifiableInformation;
            ExtendedDatatype = Masked;

        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

}
