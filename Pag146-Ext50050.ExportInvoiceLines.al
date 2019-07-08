pageextension 50050 ExportInvoiceLines extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(IncomingDoc)
        {
            action("VOX_ExportInvoiceLines")
            {
                ApplicationArea = All;
                Promoted = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ExportFile;
                Caption = 'Export Invoice Lines';
                trigger OnAction()
                Begin
                    Report.Run(50000, true, false);
                End;
            }

        }
    }

    var
        myInt: Integer;
}