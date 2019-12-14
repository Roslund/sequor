# Sequor
A frontend application, part of a project that aims to classify the distance traveled and the public transportation means used by commuters. This application is responsible for data collection and limited data pre-processing. The data is then analyzed on a backend application.

## Gamification
To encourage use of the application, commuters are awarded coupons for saving CO2 by taking public transport. As additional gamification, the CO2 saved is represented by a growing tree. The tree is initially a sapling and grows as the user saves CO2 by tracking trips. The tree will continuously grow when CO2 is saved until eventually, a coupon appears. Seeing your tree grow would hopefully be fun in of itself and could serve to motivate more people to use the application, and possibly even those who aren’t motivated to use it just for earning coupons.

![Interface](https://media.giphy.com/media/Q9GQ5LFNoWiRQoV5S7/giphy.gif)

## Style Convention
This project uses [SwiftLint](https://github.com/realm/SwiftLint) to enforce coding style convention. Install using `brew install swiftlint`, and run the tool in an XCode build phase. Project-specific settings are found in the file `.swiftlint.yml`.

## Continous Integration
[Travis CI](http://travis-ci.org) is used for continuous integration. The core functionality of the application requires manual testing since they rely on sensors not available on the simulator. Code coverage information is available in XCode, and reports are generated using [Codecov](https://codecov.io). Since the core functionality is not testable in the simulator, there are no routines regarding code coverages.

## Documentation
The application is documented using documentation comments in the code. 
The documentation for the important parts of the application have been generated using [jazzy](https://github.com/realm/jazzy) and is available at [https://roslund.github.io/sequor/](https://roslund.github.io/sequor/)

## License
This project is released under the GNU General Public License v3.0.
