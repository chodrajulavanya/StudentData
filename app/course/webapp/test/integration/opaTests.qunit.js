sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'course/test/integration/FirstJourney',
		'course/test/integration/pages/CourseList',
		'course/test/integration/pages/CourseObjectPage'
    ],
    function(JourneyRunner, opaJourney, CourseList, CourseObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('course') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCourseList: CourseList,
					onTheCourseObjectPage: CourseObjectPage
                }
            },
            opaJourney.run
        );
    }
);