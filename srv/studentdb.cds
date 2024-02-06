using { com.satinfotech.studentdb as db } from '../db/schema';

service StudentDb {
    entity Student as projection on db.Student;
    entity Student.Languages as projection on db.Student.Languages;
    entity Course.Books as projection on db.Course.Books
    entity Gender as projection on db.Gender;
    entity Course as projection on db.Course{
        @UI.Hidden: true
        ID,
        *
    };
    entity Languages as projection on db.Languages{
        @UI.Hidden: true
        ID,
        *
    };
    entity Books as projection on db.Books{
        @UI.Hidden: true
        ID,
        *
    };

}
annotate StudentDb.Student with @odata.draft.enabled;
annotate StudentDb.Course with @odata.draft.enabled;
annotate StudentDb.Languages with @odata.draft.enabled;
annotate StudentDb.Books with @odata.draft.enabled;


annotate StudentDb.Student with {
    first_name      @assert.format: '^[a-zA-Z]{2,}$';
    last_name      @assert.format: '^[a-zA-Z]{2,}$';    
    email_id     @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    pan_no       @assert.format: '^[A-Z]{5}[0-9]{4}[A-Z]$';
    //telephone @assert.format: '^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
}

annotate StudentDb.Student.Languages with @(
    UI.LineItem:[
        {
            Label: 'Languages',
            Value: lang_ID
        },
      
    ]
);



annotate StudentDb.Languages with @(
    UI.LineItem:[
        {
            Value: code
        },
        {
            Value: description
        }
    ],
     UI.FieldGroup #Languages : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                Value : description,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'LanguagesFacet',
            Label : 'Languages',
            Target : '@UI.FieldGroup#Languages',
        },
    ],

);


annotate StudentDb.Course.Books with @(
    UI.LineItem:[
        {
            Label: 'Books',
            Value: books_ID
        },
      
    ]
);

annotate StudentDb.Books with @(
    UI.LineItem:[
        {
            Value: code
        },
        {
            Value: description
        }
    ],
     UI.FieldGroup #Books : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                Value : description,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'BooksFacet',
            Label : 'Books',
            Target : '@UI.FieldGroup#Books',
        },
    ],

);

annotate StudentDb.Course with @(
UI.LineItem:[
        {
            Value : code
        },
        {          
            Value : description
        },
        {
            Value : Books.books.description
        }
    ],
    UI.FieldGroup #CourseInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                Value : description,
            },
            {
                Value : books,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentInfoFacet',
            Label : 'Student Information',
            Target : '@UI.FieldGroup#CourseInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'BooksInfoFacet',
            Label : 'Books Information',
            Target : 'Books/@UI.LineItem',
        },
    ],
);

annotate StudentDb.Gender with @(
    UI.LineItem:[
        {
            @Type: 'UI.DataField',
            Value: code
        },
        {
            @Type: 'UI.DataField',
            Label: 'Description',
            Value: description
        },
    ]
);

annotate StudentDb.Student with @( //the order of displaying the data in the form of table
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : studentid
        },
        {
            $Type : 'UI.DataField',
            Value : first_name
        },
        {
            $Type : 'UI.DataField',
            Value : last_name
        },
        {
            $Type : 'UI.DataField',
            Label :'Gender', // label for display
            Value : gen // the value that is display on the table
        },
        {
            $Type : 'UI.DataField',
            Value : email_id
        },
        {
            $Type : 'UI.DataField',
            Value : pan_no
        },
        {
            $Type : 'UI.DataField',
            Value : dob
        },
        {
            $Type : 'UI.DataField',
            Value : age
        },
        {
            Value : course.code
        },
        {
            Value: is_alumni
        }
    ],
    UI.SelectionFields: [ first_name, last_name, email_id ],       
);

annotate StudentDb.Student with @(
    UI.FieldGroup #StudentInformation : { // used to take input
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : studentid,
            },
            {
                $Type : 'UI.DataField',
                Value : first_name,
            },
            {
                $Type : 'UI.DataField',
                Value : last_name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Gender',
                Value : gender,// the value that is taken , it can be either as "F" or "M"
            },
            {
                $Type : 'UI.DataField',
                Value : email_id,
            },
            {
                $Type : 'UI.DataField',
                Value : pan_no,
            },
            {
                $Type : 'UI.DataField',
                Value : dob,
            },
            {
                $Type : 'UI.DataField',
                Value : course_ID
            }
          
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentInfoFacet',
            Label : 'Student Information',
            Target : '@UI.FieldGroup#StudentInformation',
        },
         {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentLanguagesFacet',
            Label : 'Student Languages Information',
            Target : 'Languages/@UI.LineItem',
        },

    ],
    
);
// annotate StudentDb.Books with @(
//     UI.LineItem: [
//         {
//             @Type: 'UI.DataField',
//             Value: code
//         },
//         {
//             @Type: 'UI.DataField',
//             Value: description
//         },
//     ],
//     UI.FieldGroup #Books : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             {
//                 Value : code,
//             },
//             {
//                 Value : description,
//             },
//         ],
//     },
//     UI.Facets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'BooksFacet',
//             Label : 'Books',
//             Target : '@UI.FieldGroup#Books',
//         },
//     ],
// );

annotate StudentDb.Student.Languages with {
    lang @(
        Common.Text: lang.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Languages',
            CollectionPath : 'Languages',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : lang_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    );
}

annotate StudentDb.Course.Books with {
    books @(
        Common.Text: books.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Books',
            CollectionPath : 'Books',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : books_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    );
}

annotate StudentDb.Student with {
    gender @(     
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Genders',
            CollectionPath : 'Gender',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : gender,
                    ValueListProperty : 'code'
                },
               
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                }
            ]
        }
    );

    course @(
        Common.Text: course.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Course',
            CollectionPath : 'Course',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : course_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                }
            ]
        }
    );
};