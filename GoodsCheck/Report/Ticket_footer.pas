
procedure PayfrxDBDatasetEFECTIVOOnBeforePrint(Sender: TfrxComponent);
var
i:integer;                      
begin
i:=1;
 memo2.text:='';          
 if <PayfrxDBDataset."EFECTIVO"> > 0 then
 begin
 i:=i+1;                 
     memo2.text:= memo2.text+'EFECTIVO: '+FormatFloat('#0.00 €',  <PayfrxDBDataset."EFECTIVO">) +' ';
 end;
  if <PayfrxDBDataset."TARJETA"> > 0 then
 begin
 i:=i+1;                 
     memo2.text:= memo2.text+'TARJETA: '+FormatFloat('#0.00 €',  <PayfrxDBDataset."TARJETA">)+ ' ';
 end;
  if <PayfrxDBDataset."BONUS"> > 0 then
 begin
 i:=i+1;                 
     memo2.text:= memo2.text+'BONUS: '+FormatFloat('#0.00 €',   <PayfrxDBDataset."BONUS">);
 end;     
        
end;

begin

end.
