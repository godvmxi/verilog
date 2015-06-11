//-----------------文件名 sort4.v ------------------
module sort4(ra,rb,rc,rd,a,b,c,d);
  output[3:0] ra,rb,rc,rd;
  input[3:0] a,b,c,d;
  reg[3:0] ra,rb,rc,rd;
  reg[3:0] va,vb,vc,vd;
 
  always @ (a or b or c or d)
    begin
      {va,vb,vc,vd}={a,b,c,d};
      sort2(va,vc);               //va 与vc互换。
      sort2(vb,vd);               //vb 与vd互换。
      sort2(va,vb);               //va 与vb互换。
      sort2(vc,vd);               //vc 与vd互换。
      sort2(vb,vc);               //vb 与vc互换。
      {ra,rb,rc,rd}={va,vb,vc,vd};
    end
    
  task sort2;
    inout[3:0] x,y;
    reg[3:0] tmp;
    if(x>y)
      begin
        tmp=x;      //x与y变量的内容互换，要求顺序执行，所以采用阻塞赋值方式。
        x=y;
        y=tmp;
      end
  endtask

endmodule
