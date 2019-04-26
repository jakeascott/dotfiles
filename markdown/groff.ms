.TL
My first groff document
.AU
Jake Scott
.AI
Southern Oregon University
.AB
This is an abstract.
Compile groff doc to pdf with `groff -ms groff.ms -T pdf > groff.pdf`
.AE
.NH
Introcution
.PP
This is a paragraph.

Another sentence.

.pp
An indented line.
.NH
Second section
.NH 2
Subsection
.NH 2
Anouther section header
.PP
Here is some more text. I want the word 
.B "bold"
to be bold using .B.
We can have
.I italic test
with .I.
This is 
.BI bold italic
text using .BI.
.RS
.PP
Here is some more text. I want the word 
.B "bold"
to be bold using .B.
We can have
.I italic test
with .I.
This is 
.BI bold italic
text using .BI.
.RE
.PP
Here is some more text. I want the word 
.B "bold"
to be bold using .B.
We can have
.I italic test
with .I.
This is 
.BI bold italic
text using .BI.
