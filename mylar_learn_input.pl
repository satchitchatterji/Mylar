%%%%%%%%%%%% SETTINGS %%%%%%%%%%%%

learn(unsafe_next/1).

% allowed rule components
mode(action(+,-)).
mode(hazard(+,+)).
mode(hazard(+,-)).
mode(vase(+,+)).

% type declarations
base(action(example,direction)).
base(hazard(example,direction)).
base(vase(example,direction)).
base(unsafe_next(example)).

example_mode(labeled).

%%%%%%%%%%%% DATA %%%%%%%%%%%%

hazard(t3, front).
hazard(t3, right).
hazard(t3, back).
hazard(t3, left).
vase(t3, back).
action(t3, 3).
0.000::unsafe_next(t3).

hazard(t12, front).
hazard(t12, right).
hazard(t12, back).
hazard(t12, left).
vase(t12, back).
action(t12, 1).
0.000::unsafe_next(t12).

hazard(t19, front).
hazard(t19, right).
hazard(t19, back).
hazard(t19, left).
action(t19, 2).
0.000::unsafe_next(t19).

hazard(t24, front).
hazard(t24, right).
hazard(t24, back).
hazard(t24, left).
action(t24, 1).
0.000::unsafe_next(t24).

hazard(t27, front).
hazard(t27, right).
hazard(t27, back).
hazard(t27, left).
action(t27, 1).
0.000::unsafe_next(t27).

hazard(t28, front).
hazard(t28, right).
hazard(t28, back).
hazard(t28, left).
action(t28, 3).
0.000::unsafe_next(t28).

hazard(t29, front).
hazard(t29, right).
hazard(t29, back).
hazard(t29, left).
action(t29, 2).
0.000::unsafe_next(t29).

hazard(t35, front).
hazard(t35, right).
hazard(t35, back).
hazard(t35, left).
action(t35, 2).
0.000::unsafe_next(t35).

hazard(t55, front).
hazard(t55, back).
hazard(t55, left).
action(t55, 1).
0.000::unsafe_next(t55).

hazard(t59, front).
hazard(t59, back).
hazard(t59, left).
action(t59, 1).
0.000::unsafe_next(t59).

hazard(t61, front).
hazard(t61, back).
hazard(t61, left).
action(t61, 3).
0.000::unsafe_next(t61).

hazard(t62, front).
hazard(t62, back).
hazard(t62, left).
action(t62, 2).
0.000::unsafe_next(t62).

hazard(t97, front).
hazard(t97, back).
hazard(t97, left).
action(t97, 3).
0.000::unsafe_next(t97).

hazard(t100, front).
hazard(t100, back).
hazard(t100, left).
action(t100, 2).
0.000::unsafe_next(t100).

hazard(t101, front).
hazard(t101, back).
hazard(t101, left).
action(t101, 2).
0.000::unsafe_next(t101).

hazard(t102, front).
hazard(t102, right).
hazard(t102, back).
hazard(t102, left).
action(t102, 3).
0.000::unsafe_next(t102).

hazard(t103, front).
hazard(t103, back).
hazard(t103, left).
action(t103, 2).
0.000::unsafe_next(t103).

hazard(t104, front).
hazard(t104, back).
hazard(t104, left).
action(t104, 0).
0.000::unsafe_next(t104).

hazard(t106, front).
hazard(t106, back).
hazard(t106, left).
action(t106, 1).
0.000::unsafe_next(t106).

hazard(t109, front).
hazard(t109, back).
hazard(t109, left).
action(t109, 3).
0.000::unsafe_next(t109).

hazard(t111, front).
hazard(t111, back).
hazard(t111, left).
action(t111, 3).
0.000::unsafe_next(t111).

hazard(t116, front).
hazard(t116, right).
hazard(t116, back).
hazard(t116, left).
action(t116, 3).
0.000::unsafe_next(t116).

hazard(t127, front).
hazard(t127, right).
hazard(t127, back).
hazard(t127, left).
action(t127, 3).
0.000::unsafe_next(t127).

hazard(t133, front).
hazard(t133, right).
hazard(t133, back).
hazard(t133, left).
action(t133, 3).
0.000::unsafe_next(t133).

hazard(t139, front).
hazard(t139, right).
hazard(t139, back).
hazard(t139, left).
action(t139, 0).
0.000::unsafe_next(t139).

hazard(t145, front).
hazard(t145, right).
hazard(t145, back).
hazard(t145, left).
action(t145, 1).
0.000::unsafe_next(t145).

hazard(t149, front).
hazard(t149, right).
hazard(t149, back).
hazard(t149, left).
action(t149, 0).
0.000::unsafe_next(t149).

hazard(t152, front).
hazard(t152, right).
hazard(t152, back).
hazard(t152, left).
action(t152, 1).
0.000::unsafe_next(t152).

hazard(t163, front).
hazard(t163, right).
hazard(t163, back).
hazard(t163, left).
action(t163, 2).
0.000::unsafe_next(t163).

hazard(t170, right).
hazard(t170, back).
hazard(t170, left).
action(t170, 2).
0.000::unsafe_next(t170).

hazard(t176, right).
hazard(t176, back).
hazard(t176, left).
action(t176, 3).
0.000::unsafe_next(t176).

hazard(t177, right).
hazard(t177, back).
hazard(t177, left).
action(t177, 2).
0.000::unsafe_next(t177).

hazard(t180, right).
hazard(t180, back).
hazard(t180, left).
action(t180, 3).
0.000::unsafe_next(t180).

hazard(t185, right).
hazard(t185, back).
hazard(t185, left).
action(t185, 0).
0.000::unsafe_next(t185).

hazard(t189, right).
hazard(t189, back).
hazard(t189, left).
action(t189, 0).
0.000::unsafe_next(t189).

hazard(t190, right).
hazard(t190, back).
hazard(t190, left).
action(t190, 3).
0.000::unsafe_next(t190).

hazard(t194, right).
hazard(t194, back).
hazard(t194, left).
action(t194, 3).
0.000::unsafe_next(t194).

hazard(t212, right).
hazard(t212, back).
hazard(t212, left).
action(t212, 1).
0.000::unsafe_next(t212).

hazard(t216, right).
hazard(t216, back).
hazard(t216, left).
action(t216, 2).
0.000::unsafe_next(t216).

hazard(t217, right).
hazard(t217, back).
hazard(t217, left).
action(t217, 0).
0.000::unsafe_next(t217).

hazard(t224, front).
hazard(t224, right).
hazard(t224, back).
hazard(t224, left).
action(t224, 3).
0.000::unsafe_next(t224).

hazard(t231, front).
hazard(t231, right).
hazard(t231, back).
hazard(t231, left).
action(t231, 2).
0.000::unsafe_next(t231).

hazard(t241, front).
hazard(t241, right).
hazard(t241, back).
hazard(t241, left).
action(t241, 1).
0.000::unsafe_next(t241).

hazard(t254, front).
hazard(t254, right).
hazard(t254, back).
hazard(t254, left).
action(t254, 0).
0.000::unsafe_next(t254).

hazard(t262, front).
hazard(t262, right).
hazard(t262, back).
hazard(t262, left).
action(t262, 2).
0.000::unsafe_next(t262).

hazard(t263, front).
hazard(t263, right).
hazard(t263, back).
hazard(t263, left).
action(t263, 2).
0.000::unsafe_next(t263).

hazard(t266, front).
hazard(t266, right).
hazard(t266, back).
action(t266, 3).
0.000::unsafe_next(t266).

hazard(t267, front).
hazard(t267, right).
hazard(t267, back).
action(t267, 0).
0.000::unsafe_next(t267).

hazard(t271, front).
hazard(t271, right).
hazard(t271, back).
action(t271, 2).
0.000::unsafe_next(t271).

hazard(t275, front).
hazard(t275, right).
hazard(t275, back).
action(t275, 2).
0.000::unsafe_next(t275).

hazard(t278, front).
hazard(t278, right).
hazard(t278, back).
action(t278, 3).
0.000::unsafe_next(t278).

hazard(t279, front).
hazard(t279, right).
hazard(t279, back).
action(t279, 2).
0.000::unsafe_next(t279).

hazard(t280, front).
hazard(t280, right).
hazard(t280, back).
action(t280, 1).
0.000::unsafe_next(t280).

hazard(t283, front).
hazard(t283, right).
hazard(t283, back).
action(t283, 3).
0.000::unsafe_next(t283).

hazard(t284, front).
hazard(t284, right).
hazard(t284, back).
action(t284, 3).
0.000::unsafe_next(t284).

hazard(t289, front).
hazard(t289, right).
hazard(t289, back).
hazard(t289, left).
action(t289, 2).
0.000::unsafe_next(t289).

hazard(t298, front).
hazard(t298, right).
hazard(t298, back).
hazard(t298, left).
action(t298, 0).
0.000::unsafe_next(t298).

hazard(t299, front).
hazard(t299, right).
hazard(t299, back).
hazard(t299, left).
action(t299, 0).
0.000::unsafe_next(t299).

hazard(t323, front).
hazard(t323, right).
hazard(t323, left).
action(t323, 0).
0.000::unsafe_next(t323).

hazard(t324, front).
hazard(t324, right).
hazard(t324, left).
action(t324, 1).
0.000::unsafe_next(t324).

hazard(t329, front).
hazard(t329, right).
hazard(t329, left).
action(t329, 2).
0.000::unsafe_next(t329).

hazard(t332, front).
hazard(t332, right).
hazard(t332, left).
vase(t332, back).
action(t332, 1).
0.000::unsafe_next(t332).

hazard(t336, front).
hazard(t336, right).
hazard(t336, left).
vase(t336, back).
action(t336, 1).
0.000::unsafe_next(t336).

hazard(t344, front).
hazard(t344, right).
hazard(t344, left).
vase(t344, back).
action(t344, 3).
0.000::unsafe_next(t344).

hazard(t345, front).
hazard(t345, right).
hazard(t345, left).
vase(t345, back).
action(t345, 3).
0.000::unsafe_next(t345).

hazard(t354, front).
hazard(t354, right).
hazard(t354, left).
vase(t354, back).
action(t354, 1).
0.000::unsafe_next(t354).

hazard(t357, front).
hazard(t357, right).
hazard(t357, left).
vase(t357, back).
action(t357, 2).
0.000::unsafe_next(t357).

hazard(t360, front).
hazard(t360, right).
hazard(t360, left).
vase(t360, back).
action(t360, 1).
0.000::unsafe_next(t360).

hazard(t390, front).
hazard(t390, right).
hazard(t390, left).
action(t390, 2).
0.000::unsafe_next(t390).

hazard(t402, front).
hazard(t402, right).
hazard(t402, left).
action(t402, 0).
0.000::unsafe_next(t402).

hazard(t403, front).
hazard(t403, right).
hazard(t403, back).
hazard(t403, left).
action(t403, 3).
0.000::unsafe_next(t403).

hazard(t413, front).
hazard(t413, right).
hazard(t413, back).
hazard(t413, left).
action(t413, 1).
0.000::unsafe_next(t413).

hazard(t416, front).
hazard(t416, right).
hazard(t416, back).
hazard(t416, left).
action(t416, 2).
0.000::unsafe_next(t416).

hazard(t421, front).
hazard(t421, right).
hazard(t421, back).
hazard(t421, left).
action(t421, 0).
0.000::unsafe_next(t421).

hazard(t426, front).
hazard(t426, right).
hazard(t426, back).
hazard(t426, left).
action(t426, 2).
0.000::unsafe_next(t426).

hazard(t435, front).
hazard(t435, right).
hazard(t435, back).
hazard(t435, left).
action(t435, 3).
0.000::unsafe_next(t435).

hazard(t437, front).
hazard(t437, right).
hazard(t437, back).
hazard(t437, left).
action(t437, 3).
0.000::unsafe_next(t437).

hazard(t439, front).
hazard(t439, right).
hazard(t439, back).
hazard(t439, left).
action(t439, 2).
0.000::unsafe_next(t439).

hazard(t444, front).
hazard(t444, right).
hazard(t444, back).
hazard(t444, left).
action(t444, 3).
0.000::unsafe_next(t444).

hazard(t458, front).
hazard(t458, right).
hazard(t458, back).
hazard(t458, left).
action(t458, 2).
0.000::unsafe_next(t458).

hazard(t459, front).
hazard(t459, right).
hazard(t459, back).
hazard(t459, left).
action(t459, 2).
0.000::unsafe_next(t459).

hazard(t462, front).
hazard(t462, right).
hazard(t462, back).
hazard(t462, left).
action(t462, 1).
0.000::unsafe_next(t462).

hazard(t475, front).
hazard(t475, right).
hazard(t475, back).
hazard(t475, left).
action(t475, 2).
1.000::unsafe_next(t475).

hazard(t476, front).
hazard(t476, right).
hazard(t476, back).
hazard(t476, left).
action(t476, 0).
1.000::unsafe_next(t476).

hazard(t477, front).
hazard(t477, right).
hazard(t477, back).
hazard(t477, left).
action(t477, 3).
1.000::unsafe_next(t477).

hazard(t478, front).
hazard(t478, right).
hazard(t478, back).
hazard(t478, left).
action(t478, 1).
1.000::unsafe_next(t478).

hazard(t479, front).
hazard(t479, right).
hazard(t479, back).
hazard(t479, left).
action(t479, 2).
1.000::unsafe_next(t479).

hazard(t480, front).
hazard(t480, right).
hazard(t480, back).
hazard(t480, left).
action(t480, 0).
1.000::unsafe_next(t480).

hazard(t481, front).
hazard(t481, right).
hazard(t481, back).
hazard(t481, left).
action(t481, 2).
1.000::unsafe_next(t481).

hazard(t482, front).
hazard(t482, right).
hazard(t482, back).
hazard(t482, left).
action(t482, 3).
1.000::unsafe_next(t482).

hazard(t483, front).
hazard(t483, right).
hazard(t483, back).
hazard(t483, left).
action(t483, 0).
1.000::unsafe_next(t483).

hazard(t484, front).
hazard(t484, right).
hazard(t484, back).
hazard(t484, left).
action(t484, 2).
1.000::unsafe_next(t484).

hazard(t485, front).
hazard(t485, right).
hazard(t485, back).
hazard(t485, left).
action(t485, 3).
1.000::unsafe_next(t485).

hazard(t486, front).
hazard(t486, right).
hazard(t486, back).
hazard(t486, left).
action(t486, 0).
1.000::unsafe_next(t486).

hazard(t487, front).
hazard(t487, right).
hazard(t487, back).
hazard(t487, left).
action(t487, 0).
1.000::unsafe_next(t487).

hazard(t488, front).
hazard(t488, right).
hazard(t488, back).
hazard(t488, left).
action(t488, 3).
1.000::unsafe_next(t488).

hazard(t489, front).
hazard(t489, right).
hazard(t489, back).
hazard(t489, left).
action(t489, 0).
1.000::unsafe_next(t489).

hazard(t490, front).
hazard(t490, right).
hazard(t490, back).
hazard(t490, left).
action(t490, 3).
1.000::unsafe_next(t490).

hazard(t491, front).
hazard(t491, right).
hazard(t491, back).
hazard(t491, left).
action(t491, 3).
1.000::unsafe_next(t491).

hazard(t492, front).
hazard(t492, right).
hazard(t492, back).
hazard(t492, left).
action(t492, 1).
1.000::unsafe_next(t492).

hazard(t493, front).
hazard(t493, right).
hazard(t493, back).
hazard(t493, left).
action(t493, 2).
1.000::unsafe_next(t493).

hazard(t494, front).
hazard(t494, right).
hazard(t494, back).
hazard(t494, left).
action(t494, 3).
1.000::unsafe_next(t494).

hazard(t495, front).
hazard(t495, right).
hazard(t495, back).
hazard(t495, left).
action(t495, 1).
1.000::unsafe_next(t495).

hazard(t496, front).
hazard(t496, right).
hazard(t496, back).
hazard(t496, left).
action(t496, 2).
1.000::unsafe_next(t496).

hazard(t497, front).
hazard(t497, right).
hazard(t497, back).
hazard(t497, left).
action(t497, 2).
1.000::unsafe_next(t497).

hazard(t498, front).
hazard(t498, right).
hazard(t498, back).
hazard(t498, left).
action(t498, 2).
1.000::unsafe_next(t498).

hazard(t499, front).
hazard(t499, right).
hazard(t499, back).
hazard(t499, left).
action(t499, 2).
1.000::unsafe_next(t499).

hazard(t500, front).
hazard(t500, right).
hazard(t500, back).
hazard(t500, left).
action(t500, 1).
1.000::unsafe_next(t500).

hazard(t501, front).
hazard(t501, right).
hazard(t501, back).
hazard(t501, left).
action(t501, 2).
1.000::unsafe_next(t501).

hazard(t502, front).
hazard(t502, right).
hazard(t502, back).
hazard(t502, left).
action(t502, 3).
1.000::unsafe_next(t502).

hazard(t503, front).
hazard(t503, right).
hazard(t503, back).
action(t503, 0).
1.000::unsafe_next(t503).

hazard(t504, front).
hazard(t504, right).
hazard(t504, back).
action(t504, 1).
1.000::unsafe_next(t504).

hazard(t505, front).
hazard(t505, right).
hazard(t505, back).
action(t505, 0).
1.000::unsafe_next(t505).

hazard(t506, front).
hazard(t506, right).
hazard(t506, back).
action(t506, 3).
1.000::unsafe_next(t506).

hazard(t507, front).
hazard(t507, right).
hazard(t507, back).
action(t507, 1).
1.000::unsafe_next(t507).

hazard(t508, front).
hazard(t508, right).
hazard(t508, back).
action(t508, 3).
1.000::unsafe_next(t508).

hazard(t509, front).
hazard(t509, right).
hazard(t509, back).
action(t509, 2).
1.000::unsafe_next(t509).

hazard(t510, front).
hazard(t510, right).
hazard(t510, back).
action(t510, 1).
1.000::unsafe_next(t510).

hazard(t511, front).
hazard(t511, right).
hazard(t511, back).
action(t511, 2).
1.000::unsafe_next(t511).

hazard(t512, front).
hazard(t512, right).
hazard(t512, back).
action(t512, 0).
1.000::unsafe_next(t512).

hazard(t513, front).
hazard(t513, right).
hazard(t513, back).
action(t513, 3).
1.000::unsafe_next(t513).

hazard(t514, front).
hazard(t514, right).
hazard(t514, back).
action(t514, 0).
1.000::unsafe_next(t514).

hazard(t515, front).
hazard(t515, right).
hazard(t515, back).
action(t515, 1).
1.000::unsafe_next(t515).

hazard(t516, front).
hazard(t516, right).
hazard(t516, back).
action(t516, 2).
1.000::unsafe_next(t516).

hazard(t517, front).
hazard(t517, right).
hazard(t517, back).
action(t517, 3).
1.000::unsafe_next(t517).

hazard(t518, front).
hazard(t518, right).
hazard(t518, back).
action(t518, 1).
1.000::unsafe_next(t518).

hazard(t519, front).
hazard(t519, right).
hazard(t519, back).
action(t519, 0).
1.000::unsafe_next(t519).

hazard(t520, front).
hazard(t520, right).
hazard(t520, back).
action(t520, 1).
1.000::unsafe_next(t520).

hazard(t521, front).
hazard(t521, right).
hazard(t521, back).
action(t521, 1).
1.000::unsafe_next(t521).

hazard(t522, front).
hazard(t522, right).
hazard(t522, back).
action(t522, 2).
1.000::unsafe_next(t522).

hazard(t523, front).
hazard(t523, right).
hazard(t523, back).
action(t523, 2).
1.000::unsafe_next(t523).

hazard(t524, front).
hazard(t524, right).
hazard(t524, back).
action(t524, 0).
1.000::unsafe_next(t524).

hazard(t525, front).
hazard(t525, right).
hazard(t525, back).
action(t525, 2).
1.000::unsafe_next(t525).

hazard(t526, front).
hazard(t526, right).
hazard(t526, back).
action(t526, 0).
1.000::unsafe_next(t526).

hazard(t527, front).
hazard(t527, right).
hazard(t527, back).
action(t527, 2).
1.000::unsafe_next(t527).

hazard(t528, front).
hazard(t528, right).
hazard(t528, back).
action(t528, 2).
1.000::unsafe_next(t528).

hazard(t529, front).
hazard(t529, right).
hazard(t529, back).
action(t529, 0).
1.000::unsafe_next(t529).

hazard(t530, front).
hazard(t530, right).
hazard(t530, back).
action(t530, 3).
1.000::unsafe_next(t530).

hazard(t531, front).
hazard(t531, right).
hazard(t531, back).
action(t531, 1).
1.000::unsafe_next(t531).

hazard(t532, front).
hazard(t532, right).
hazard(t532, back).
action(t532, 2).
1.000::unsafe_next(t532).

hazard(t533, front).
hazard(t533, right).
hazard(t533, back).
action(t533, 0).
1.000::unsafe_next(t533).

hazard(t534, front).
hazard(t534, right).
hazard(t534, back).
action(t534, 1).
1.000::unsafe_next(t534).

hazard(t535, front).
hazard(t535, right).
hazard(t535, back).
action(t535, 3).
1.000::unsafe_next(t535).

hazard(t536, front).
hazard(t536, right).
hazard(t536, back).
action(t536, 0).
1.000::unsafe_next(t536).

hazard(t537, front).
hazard(t537, right).
hazard(t537, back).
action(t537, 2).
1.000::unsafe_next(t537).

hazard(t540, front).
hazard(t540, right).
hazard(t540, back).
action(t540, 0).
0.000::unsafe_next(t540).

hazard(t543, front).
hazard(t543, right).
hazard(t543, back).
action(t543, 2).
0.000::unsafe_next(t543).

hazard(t544, front).
hazard(t544, right).
hazard(t544, back).
hazard(t544, left).
action(t544, 3).
0.000::unsafe_next(t544).

hazard(t545, front).
hazard(t545, right).
hazard(t545, back).
hazard(t545, left).
action(t545, 1).
0.000::unsafe_next(t545).

hazard(t562, front).
hazard(t562, right).
hazard(t562, left).
action(t562, 0).
0.000::unsafe_next(t562).

hazard(t567, front).
hazard(t567, right).
hazard(t567, left).
action(t567, 2).
0.000::unsafe_next(t567).

hazard(t572, front).
hazard(t572, right).
hazard(t572, left).
action(t572, 1).
0.000::unsafe_next(t572).

hazard(t574, front).
hazard(t574, right).
hazard(t574, left).
action(t574, 3).
0.000::unsafe_next(t574).

hazard(t575, front).
hazard(t575, right).
hazard(t575, left).
action(t575, 2).
0.000::unsafe_next(t575).

hazard(t576, front).
hazard(t576, right).
hazard(t576, left).
action(t576, 0).
0.000::unsafe_next(t576).

hazard(t577, front).
hazard(t577, right).
hazard(t577, left).
action(t577, 2).
0.000::unsafe_next(t577).

hazard(t580, front).
hazard(t580, right).
hazard(t580, left).
action(t580, 3).
0.000::unsafe_next(t580).

hazard(t589, front).
hazard(t589, right).
hazard(t589, back).
hazard(t589, left).
action(t589, 2).
0.000::unsafe_next(t589).

hazard(t591, front).
hazard(t591, right).
hazard(t591, back).
hazard(t591, left).
action(t591, 1).
0.000::unsafe_next(t591).

hazard(t592, front).
hazard(t592, right).
hazard(t592, back).
hazard(t592, left).
action(t592, 2).
0.000::unsafe_next(t592).

hazard(t594, front).
hazard(t594, right).
hazard(t594, back).
hazard(t594, left).
action(t594, 1).
0.000::unsafe_next(t594).

hazard(t595, front).
hazard(t595, right).
hazard(t595, back).
hazard(t595, left).
action(t595, 2).
0.000::unsafe_next(t595).

hazard(t611, front).
hazard(t611, right).
hazard(t611, back).
hazard(t611, left).
action(t611, 1).
0.000::unsafe_next(t611).

hazard(t616, front).
hazard(t616, right).
hazard(t616, back).
hazard(t616, left).
action(t616, 1).
0.000::unsafe_next(t616).

hazard(t619, front).
hazard(t619, right).
hazard(t619, back).
hazard(t619, left).
action(t619, 2).
0.000::unsafe_next(t619).

hazard(t621, front).
hazard(t621, right).
hazard(t621, back).
hazard(t621, left).
action(t621, 1).
0.000::unsafe_next(t621).

hazard(t628, front).
hazard(t628, right).
hazard(t628, back).
hazard(t628, left).
action(t628, 2).
0.000::unsafe_next(t628).

hazard(t632, front).
hazard(t632, right).
hazard(t632, back).
hazard(t632, left).
action(t632, 2).
0.000::unsafe_next(t632).

hazard(t637, front).
hazard(t637, right).
hazard(t637, back).
hazard(t637, left).
action(t637, 2).
0.000::unsafe_next(t637).

hazard(t638, front).
hazard(t638, right).
hazard(t638, back).
hazard(t638, left).
action(t638, 3).
0.000::unsafe_next(t638).

hazard(t639, front).
hazard(t639, right).
hazard(t639, back).
hazard(t639, left).
action(t639, 2).
0.000::unsafe_next(t639).

hazard(t649, front).
hazard(t649, right).
hazard(t649, back).
hazard(t649, left).
action(t649, 1).
0.000::unsafe_next(t649).

hazard(t656, front).
hazard(t656, right).
hazard(t656, back).
action(t656, 2).
0.000::unsafe_next(t656).

hazard(t663, front).
hazard(t663, right).
hazard(t663, back).
action(t663, 1).
0.000::unsafe_next(t663).

hazard(t672, front).
hazard(t672, right).
hazard(t672, back).
action(t672, 2).
0.000::unsafe_next(t672).

hazard(t684, front).
hazard(t684, right).
hazard(t684, back).
hazard(t684, left).
action(t684, 3).
0.000::unsafe_next(t684).

hazard(t691, front).
hazard(t691, right).
hazard(t691, back).
hazard(t691, left).
action(t691, 1).
0.000::unsafe_next(t691).

hazard(t703, front).
hazard(t703, right).
hazard(t703, back).
hazard(t703, left).
action(t703, 2).
0.000::unsafe_next(t703).

hazard(t707, front).
hazard(t707, right).
hazard(t707, back).
hazard(t707, left).
action(t707, 2).
0.000::unsafe_next(t707).

hazard(t712, front).
hazard(t712, right).
hazard(t712, back).
hazard(t712, left).
action(t712, 2).
0.000::unsafe_next(t712).

hazard(t718, front).
hazard(t718, right).
hazard(t718, left).
action(t718, 2).
0.000::unsafe_next(t718).

hazard(t723, front).
hazard(t723, right).
hazard(t723, left).
action(t723, 1).
0.000::unsafe_next(t723).

hazard(t732, front).
hazard(t732, right).
hazard(t732, back).
hazard(t732, left).
action(t732, 0).
0.000::unsafe_next(t732).

hazard(t739, front).
hazard(t739, right).
hazard(t739, back).
hazard(t739, left).
action(t739, 1).
0.000::unsafe_next(t739).

hazard(t740, front).
hazard(t740, right).
hazard(t740, back).
hazard(t740, left).
action(t740, 1).
0.000::unsafe_next(t740).

hazard(t742, front).
hazard(t742, right).
hazard(t742, back).
hazard(t742, left).
action(t742, 2).
0.000::unsafe_next(t742).

hazard(t744, front).
hazard(t744, right).
hazard(t744, back).
hazard(t744, left).
action(t744, 3).
0.000::unsafe_next(t744).

hazard(t748, front).
hazard(t748, right).
hazard(t748, back).
hazard(t748, left).
action(t748, 3).
0.000::unsafe_next(t748).

hazard(t751, front).
hazard(t751, right).
hazard(t751, back).
hazard(t751, left).
action(t751, 1).
0.000::unsafe_next(t751).

hazard(t753, front).
hazard(t753, right).
hazard(t753, back).
hazard(t753, left).
action(t753, 0).
0.000::unsafe_next(t753).

hazard(t763, front).
hazard(t763, right).
hazard(t763, back).
hazard(t763, left).
action(t763, 1).
0.000::unsafe_next(t763).

hazard(t765, front).
hazard(t765, right).
hazard(t765, back).
hazard(t765, left).
action(t765, 1).
0.000::unsafe_next(t765).

hazard(t767, front).
hazard(t767, right).
hazard(t767, back).
hazard(t767, left).
action(t767, 0).
0.000::unsafe_next(t767).

hazard(t777, front).
hazard(t777, right).
hazard(t777, back).
hazard(t777, left).
action(t777, 0).
0.000::unsafe_next(t777).

hazard(t783, front).
hazard(t783, right).
hazard(t783, back).
hazard(t783, left).
action(t783, 1).
0.000::unsafe_next(t783).

hazard(t790, front).
hazard(t790, right).
hazard(t790, back).
hazard(t790, left).
action(t790, 3).
0.000::unsafe_next(t790).

hazard(t793, front).
hazard(t793, right).
hazard(t793, back).
hazard(t793, left).
action(t793, 3).
0.000::unsafe_next(t793).

hazard(t795, front).
hazard(t795, right).
hazard(t795, back).
hazard(t795, left).
action(t795, 2).
0.000::unsafe_next(t795).

hazard(t796, front).
hazard(t796, right).
hazard(t796, back).
hazard(t796, left).
action(t796, 0).
0.000::unsafe_next(t796).

hazard(t798, front).
hazard(t798, right).
hazard(t798, back).
hazard(t798, left).
action(t798, 2).
0.000::unsafe_next(t798).

hazard(t802, front).
hazard(t802, right).
hazard(t802, back).
action(t802, 3).
0.000::unsafe_next(t802).

hazard(t807, front).
hazard(t807, right).
hazard(t807, back).
action(t807, 2).
1.000::unsafe_next(t807).

hazard(t808, front).
hazard(t808, right).
hazard(t808, back).
action(t808, 3).
1.000::unsafe_next(t808).

hazard(t809, front).
hazard(t809, right).
hazard(t809, back).
action(t809, 2).
1.000::unsafe_next(t809).

hazard(t810, front).
hazard(t810, right).
hazard(t810, back).
action(t810, 2).
1.000::unsafe_next(t810).

hazard(t811, front).
hazard(t811, right).
hazard(t811, back).
action(t811, 2).
1.000::unsafe_next(t811).

hazard(t812, front).
hazard(t812, right).
hazard(t812, back).
action(t812, 0).
1.000::unsafe_next(t812).

hazard(t813, front).
hazard(t813, right).
hazard(t813, back).
action(t813, 1).
1.000::unsafe_next(t813).

hazard(t814, front).
hazard(t814, right).
hazard(t814, back).
action(t814, 0).
1.000::unsafe_next(t814).

hazard(t815, front).
hazard(t815, right).
hazard(t815, back).
action(t815, 2).
1.000::unsafe_next(t815).

hazard(t816, front).
hazard(t816, right).
hazard(t816, back).
action(t816, 2).
1.000::unsafe_next(t816).

hazard(t817, front).
hazard(t817, right).
hazard(t817, back).
hazard(t817, left).
action(t817, 0).
1.000::unsafe_next(t817).

hazard(t818, front).
hazard(t818, right).
hazard(t818, back).
hazard(t818, left).
action(t818, 3).
1.000::unsafe_next(t818).

hazard(t819, front).
hazard(t819, right).
hazard(t819, back).
hazard(t819, left).
action(t819, 2).
1.000::unsafe_next(t819).

hazard(t820, front).
hazard(t820, right).
hazard(t820, back).
hazard(t820, left).
action(t820, 1).
1.000::unsafe_next(t820).

hazard(t821, front).
hazard(t821, right).
hazard(t821, back).
hazard(t821, left).
action(t821, 3).
1.000::unsafe_next(t821).

hazard(t822, front).
hazard(t822, right).
hazard(t822, back).
hazard(t822, left).
action(t822, 2).
1.000::unsafe_next(t822).

hazard(t823, front).
hazard(t823, right).
hazard(t823, back).
hazard(t823, left).
action(t823, 0).
1.000::unsafe_next(t823).

hazard(t824, front).
hazard(t824, right).
hazard(t824, back).
hazard(t824, left).
action(t824, 2).
1.000::unsafe_next(t824).

hazard(t825, front).
hazard(t825, right).
hazard(t825, back).
hazard(t825, left).
action(t825, 0).
1.000::unsafe_next(t825).

hazard(t826, front).
hazard(t826, right).
hazard(t826, back).
hazard(t826, left).
action(t826, 2).
1.000::unsafe_next(t826).

hazard(t827, front).
hazard(t827, right).
hazard(t827, back).
hazard(t827, left).
action(t827, 3).
1.000::unsafe_next(t827).

hazard(t828, front).
hazard(t828, right).
hazard(t828, back).
hazard(t828, left).
action(t828, 1).
1.000::unsafe_next(t828).

hazard(t829, front).
hazard(t829, right).
hazard(t829, back).
hazard(t829, left).
action(t829, 1).
1.000::unsafe_next(t829).

hazard(t830, front).
hazard(t830, right).
hazard(t830, back).
hazard(t830, left).
action(t830, 2).
1.000::unsafe_next(t830).

hazard(t831, front).
hazard(t831, right).
hazard(t831, back).
action(t831, 3).
1.000::unsafe_next(t831).

hazard(t832, front).
hazard(t832, right).
hazard(t832, back).
action(t832, 2).
1.000::unsafe_next(t832).

hazard(t833, front).
hazard(t833, right).
hazard(t833, back).
action(t833, 2).
1.000::unsafe_next(t833).

hazard(t834, front).
hazard(t834, right).
hazard(t834, back).
action(t834, 2).
1.000::unsafe_next(t834).

hazard(t835, front).
hazard(t835, right).
hazard(t835, back).
action(t835, 2).
1.000::unsafe_next(t835).

hazard(t836, front).
hazard(t836, right).
hazard(t836, back).
action(t836, 0).
1.000::unsafe_next(t836).

hazard(t837, front).
hazard(t837, right).
hazard(t837, back).
action(t837, 2).
1.000::unsafe_next(t837).

hazard(t838, front).
hazard(t838, right).
hazard(t838, back).
action(t838, 2).
1.000::unsafe_next(t838).

hazard(t839, front).
hazard(t839, right).
hazard(t839, back).
action(t839, 2).
1.000::unsafe_next(t839).

hazard(t840, front).
hazard(t840, right).
hazard(t840, back).
action(t840, 1).
1.000::unsafe_next(t840).

hazard(t841, front).
hazard(t841, right).
hazard(t841, back).
action(t841, 0).
1.000::unsafe_next(t841).

hazard(t842, front).
hazard(t842, right).
hazard(t842, back).
action(t842, 2).
1.000::unsafe_next(t842).

hazard(t843, front).
hazard(t843, right).
action(t843, 3).
1.000::unsafe_next(t843).

hazard(t844, front).
hazard(t844, right).
action(t844, 2).
1.000::unsafe_next(t844).

hazard(t845, front).
hazard(t845, right).
action(t845, 1).
1.000::unsafe_next(t845).

hazard(t846, front).
hazard(t846, right).
action(t846, 3).
1.000::unsafe_next(t846).

hazard(t847, front).
hazard(t847, right).
action(t847, 0).
1.000::unsafe_next(t847).

hazard(t848, front).
hazard(t848, right).
action(t848, 1).
1.000::unsafe_next(t848).

hazard(t849, front).
hazard(t849, right).
action(t849, 0).
1.000::unsafe_next(t849).

hazard(t850, front).
hazard(t850, right).
action(t850, 2).
1.000::unsafe_next(t850).

hazard(t851, front).
hazard(t851, right).
action(t851, 2).
1.000::unsafe_next(t851).

hazard(t854, front).
hazard(t854, right).
action(t854, 2).
0.000::unsafe_next(t854).

hazard(t860, front).
hazard(t860, right).
hazard(t860, left).
action(t860, 2).
0.000::unsafe_next(t860).

hazard(t867, front).
hazard(t867, right).
hazard(t867, left).
action(t867, 1).
0.000::unsafe_next(t867).

hazard(t870, front).
hazard(t870, right).
hazard(t870, left).
action(t870, 2).
0.000::unsafe_next(t870).

hazard(t880, front).
hazard(t880, right).
hazard(t880, left).
action(t880, 3).
0.000::unsafe_next(t880).

hazard(t881, front).
hazard(t881, right).
hazard(t881, left).
action(t881, 2).
0.000::unsafe_next(t881).

hazard(t886, front).
hazard(t886, right).
hazard(t886, left).
action(t886, 1).
0.000::unsafe_next(t886).

hazard(t887, front).
hazard(t887, right).
hazard(t887, left).
action(t887, 0).
0.000::unsafe_next(t887).

hazard(t891, front).
hazard(t891, right).
hazard(t891, left).
action(t891, 2).
0.000::unsafe_next(t891).

hazard(t894, front).
hazard(t894, right).
hazard(t894, left).
action(t894, 1).
0.000::unsafe_next(t894).

hazard(t897, front).
hazard(t897, right).
hazard(t897, left).
action(t897, 3).
0.000::unsafe_next(t897).

hazard(t898, front).
hazard(t898, right).
hazard(t898, left).
action(t898, 1).
0.000::unsafe_next(t898).

hazard(t899, front).
hazard(t899, right).
hazard(t899, left).
action(t899, 2).
0.000::unsafe_next(t899).

hazard(t901, front).
hazard(t901, right).
hazard(t901, left).
action(t901, 2).
0.000::unsafe_next(t901).

hazard(t902, front).
hazard(t902, right).
hazard(t902, left).
action(t902, 1).
0.000::unsafe_next(t902).

hazard(t908, front).
hazard(t908, right).
hazard(t908, left).
action(t908, 0).
0.000::unsafe_next(t908).

hazard(t909, front).
hazard(t909, right).
hazard(t909, left).
action(t909, 1).
0.000::unsafe_next(t909).

hazard(t910, front).
hazard(t910, right).
hazard(t910, left).
action(t910, 1).
0.000::unsafe_next(t910).

hazard(t914, front).
hazard(t914, right).
hazard(t914, left).
action(t914, 1).
0.000::unsafe_next(t914).

hazard(t916, front).
hazard(t916, right).
hazard(t916, left).
action(t916, 0).
0.000::unsafe_next(t916).

hazard(t920, front).
hazard(t920, right).
hazard(t920, left).
action(t920, 2).
0.000::unsafe_next(t920).

hazard(t927, front).
hazard(t927, right).
hazard(t927, left).
action(t927, 1).
0.000::unsafe_next(t927).

hazard(t946, front).
hazard(t946, right).
hazard(t946, left).
action(t946, 2).
0.000::unsafe_next(t946).

hazard(t948, front).
hazard(t948, right).
hazard(t948, left).
action(t948, 2).
0.000::unsafe_next(t948).

hazard(t954, front).
hazard(t954, right).
hazard(t954, back).
hazard(t954, left).
action(t954, 0).
0.000::unsafe_next(t954).

hazard(t955, right).
hazard(t955, back).
hazard(t955, left).
action(t955, 3).
0.000::unsafe_next(t955).

hazard(t956, right).
hazard(t956, back).
hazard(t956, left).
action(t956, 0).
0.000::unsafe_next(t956).

hazard(t965, front).
hazard(t965, right).
hazard(t965, back).
hazard(t965, left).
action(t965, 2).
0.000::unsafe_next(t965).

hazard(t969, front).
hazard(t969, right).
hazard(t969, back).
hazard(t969, left).
action(t969, 2).
0.000::unsafe_next(t969).

hazard(t990, front).
hazard(t990, right).
hazard(t990, back).
action(t990, 2).
0.000::unsafe_next(t990).

hazard(t993, front).
hazard(t993, right).
hazard(t993, back).
action(t993, 2).
0.000::unsafe_next(t993).

hazard(t996, front).
hazard(t996, right).
hazard(t996, back).
action(t996, 2).
0.000::unsafe_next(t996).

hazard(t997, front).
hazard(t997, right).
hazard(t997, back).
action(t997, 0).
0.000::unsafe_next(t997).

hazard(t998, front).
hazard(t998, right).
hazard(t998, back).
action(t998, 3).
0.000::unsafe_next(t998).

hazard(t999, front).
hazard(t999, right).
hazard(t999, back).
action(t999, 2).
0.000::unsafe_next(t999).
