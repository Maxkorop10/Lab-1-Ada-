with Ada.Text_IO;
with Ada.Task_Identification;

procedure Main is

   can_stop : boolean := false;
   pragma Atomic(can_stop);

   task type break_thread;
   task type main_thread(id : natural);

   task body break_thread is
   begin
      delay 5.0;
      can_stop := true;
   end break_thread;

   task body main_thread is
      sum : Long_Long_Integer := 0;
      count : Long_Long_Integer;
   begin
      loop
         sum := sum + count * 2;
         count := count + 1;
         exit when can_stop;
      end loop;
      delay 1.0;

      Ada.Text_IO.Put_Line("Id:" & id'Img & ", Sum:" & sum'Img & " and count:" & count'Img);
   end main_thread;



   b1 : break_thread;
   Threads: array(1..5) of access main_thread;
begin
   for i in 1..Threads'Length loop
      Threads(i) := new main_thread(i);
   end loop;

end Main;
