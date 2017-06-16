/*
*   Legt Einstellungen für grad-civs Zivilisten fest.
*/

enableCivs = 1;                                                                 // Zivilisten aktiviert (0/1)

maxCivs = 60;                                                                   // maximale Anzahl an Zivilisten
spawnDistances[] = {1000,4500};                                                 // Mindest- und Maximalabstand zu allen Spielern, in denen Zivilisten spawnen
backpackProbability = 0.15;                                                     // Wahrscheinlichkeit, dass Zivilisten mit Backpacks spawnen (0-1)
exitOn = "";                                                                    // Skriptbedingung, ab der keine weiteren Zivilisten mehr spawnen
onSpawn = "";                                                                   // Skript, das ausgeführt wird, wenn ein Zivilist spawnt
onHeldUp = "";                                                                  // Skript, das ausgeführt wird, wenn ein Zivilist angehalten wird (Spieler zeigt mit Waffe auf Zivilist)
