namespace com.satinfotech.studentdb;
using { managed, cuid } from '@sap/cds/common';

@assert.unique:{
    studentid:[studentid]
}
entity Student: cuid, managed 
{
 //key ID: UUID;
 @title: 'StudentID'
 studentid: String(5);
 @title: 'First Name'
 first_name:String(40) @mandatory;
 @title: 'Last Name'
 last_name:String(40) @mandatory;
 @title :'Gender'
 virtual gen :String(6) @Core.Computed;
 gender : String(6);
 @title: 'EmailID'
 email_id:String(100) @mandatory;
 @title: 'Pan No'
 pan_no:String(150) @mandatory;
 @title:'Date of Birth'
 dob: Date @mandatory;
 @title : 'Course'
 course : Association to Course;
 @title :'Age'
 virtual age: Integer @Core.Computed; 
 @title: 'Languages Known'
    Languages: Composition of many {
        key ID: UUID;
        lang: Association to Languages;
    }
@title: 'Is Alumni'
is_alumni: Boolean default false;


}


/*entity StudentLanguages: managed,cuid {
    studentid: Association to Student;
    langid: Association to Languages;
}

entity CoursesBooks: managed,cuid {
    course: Association to Courses;
    bookid: Association to Books;
}*/

@cds.persistence.skip
entity Gender {
 @title:'code'
 key code : String(1);
 @title :'Description'
 description : String(10); 
 
}

entity Course : cuid, managed {
    @title: 'Code'
    code: String(3);
    @title : 'Description'
    description : String(50);
     @title: 'Books'
    Books: Composition of many {
        key ID: UUID;
        books: Association to Books;
    }

}


entity Languages: cuid, managed {
    @title: 'Code'
    code: String(2);
    @title: 'Description'
    description: String(20);
}

entity Books : cuid, managed {
    @title: 'Code'
    code: String(2);
    @title: 'Description'
    description: String(20);
}