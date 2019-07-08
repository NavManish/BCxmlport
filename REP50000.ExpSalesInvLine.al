report 50000 VOX_ExpSalesInvLine
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Export Sales Invoice Lines';

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("VOX_Invoice Filters")
                {
                    Caption = 'Sales Invoice Filters';
                    field(PostDate; PostDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date';
                    }
                    field(SrvZone1; SrvZone)
                    {
                        ApplicationArea = All;
                        Caption = 'Service Zone Code';
                        TableRelation = "Service Zone";
                    }
                }
            }
        }

        actions
        {

        }
    }
    trigger OnPreReport()
    begin
        SalesInvHeader.reset();
        if PostDate <> 0D then
            SalesInvHeader.SetRange("Posting Date", PostDate);
        if SrvZone <> '' then
            SalesInvHeader.SetRange("VOX_Service Zone Code", SrvZone);
        if SalesInvHeader.count() <> 0 then
            xmlport.Run(50000, false, false, SalesInvHeader);
    end;

    var
        SalesInvHeader: Record "Sales Invoice Header";
        SrvZone: code[10];
        PostDate: Date;

}