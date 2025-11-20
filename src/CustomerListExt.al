pageextension 50100 "Customer List Ext" extends "Customer List"
{
    trigger OnOpenPage()
    begin
        Message('Welcome to 272-jenkins extension');
    end;
}
