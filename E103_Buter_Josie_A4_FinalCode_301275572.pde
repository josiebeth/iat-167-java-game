//music objects and imports
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
Minim minim;
Minim m;
AudioPlayer player;
AudioPlayer sound;

//player, enemy and power up declaration
Princess elcri;
Abductor tagon;
PowerUp healthPack1, healthPack2, healthPack3;
ArrayList<BasicEnemy> ba1 = new ArrayList<BasicEnemy>();
ArrayList<BasicEnemy> ba2 = new ArrayList<BasicEnemy>();
ArrayList<BasicEnemy> ba3 = new ArrayList<BasicEnemy>();
ArrayList<PowerUp> pu1 = new ArrayList<PowerUp>();
ArrayList<PowerUp> pu2 = new ArrayList<PowerUp>();
ArrayList<PowerUp> pu3 = new ArrayList<PowerUp>();

//tile array list and map declaration
ArrayList<Tile> tilesOne = new ArrayList<Tile>();
ArrayList<Tile> tilesTwo = new ArrayList<Tile>();
ArrayList<Tile> tilesThree = new ArrayList<Tile>();

//custom map arrays for each level
int[][] levelOne = {{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 1, 1, 0, 0, 4, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 4, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 4, 1, 0, 1, 3, 1, 1, 1, 0, 4, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                    {1, 11, 0, 6, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 3, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 4, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};

int[][] levelTwo = {{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 8, 0, 0, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                    {1, 1, 0, 1, 4, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 0, 1, 0, 0, 0, 0, 0, 4, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 8, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 7, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 0, 0, 1, 7, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 8, 0, 0, 4, 1, 0, 0, 0, 8, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 11, 6, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 4, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 7, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};

int[][] levelThree = {{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 1, 0, 0, 0, 0, 10, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 11, 6, 1, 4, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 10, 0, 0, 0, 1, 1, 1, 4, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 10, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 0, 1, 4, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
                      {1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 0, 0, 0, 0, 0, 9, 0, 0, 1, 0, 0, 0, 9, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 1, 4, 1, 1, 1, 4, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 0, 0, 0, 0, 1, 1, 1, 0, 4, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
                      {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};

/*MAP LEGEND 
 1 = wall
 0 = pathway for player
 2 = mountain enemy 1 (Rian)
 3 = mounatin enemy 2 (Amond)
 4 = power up --> red = speed, blue = freeze enemies
 5 = health pack (end of level)
 6 = player (Elcri)
 7 = ocean enemy 1 (Ars)
 8 = ocean enemy 2 (Xago)
 9 = forest enemy 1 (Squagle)
 10 = forest enemy 2 (Squagle)
 11 = abductor (Tagon)
 */

//sound effect playing variables
final String HIT = "hit.wav";
final String POWER_UP = "powerUp.wav";
//sound effect playing function
void playSound(String file) {
  sound = m.loadFile(file, 2048);
  sound.play();
}

void setup () {
  size(1000, 600);  
  //music object and file loading
  minim = new Minim(this);
  m = new Minim(this);
  player = minim.loadFile("horror_atmosphere_start.mp3");
  player.loop(50);

  //image loading for player objects
  princess = loadImage("images/elcri/Elcri.png");
  princessSpeed = loadImage("images/elcri/Elcri_speed.png");
  princessFreeze = loadImage("images/elcri/Elcri_freeze.png");
  princessBoss = loadImage("images/elcri/Elcri_boss.png");
  arrow = loadImage("images/elcri/elcri_arrow.png");
  //images loading for enemies
  abductor = loadImage("images/enemies/Tagon.png");
  tagonBoss = loadImage("images/enemies/Tagon_boss.png");
  mountainEnemy1 = loadImage("images/enemies/Rian.png");
  mountainEnemy2 = loadImage("images/enemies/Amond.png");
  oceanEnemy1 = loadImage("images/enemies/Ars.png");
  oceanEnemy2 = loadImage("images/enemies/Xago.png");
  forestEnemy1 = loadImage("images/enemies/Squagle.png");
  
  //image loading for power ups and health
  freezePU = loadImage("images/freezePU.png");
  speedPU = loadImage("images/speedPU.png");
  health = loadImage("images/health.png");

  //font loading
  title = loadFont("CicleGordita-48.vlw");
  textFont(title);

  //entire screen images loading
  start = loadImage("images/startScreen.jpg");
  instructions = loadImage("images/instructions.jpg");
  loss = loadImage("images/gameOver.jpg");
  win = loadImage("images/winScreen.jpg");
  battleBG = loadImage("images/battleBG.jpg");

  //narration screens and objects
  firstFrame = loadImage("images/narration/firstFrame.jpg");
  firstFrameElcri = loadImage("images/narration/firstFrameElcri.png");
  secondFrame = loadImage("images/narration/secondFrame.jpg");
  secondFrameTagon = loadImage("images/narration/secondFrameTagon.png");
  thirdFrame = loadImage("images/narration/thirdFrame.jpg");
  thirdFrameTagon = loadImage("images/narration/thirdFrameTagon.png");
  thirdFrameElcri = loadImage("images/narration/elcriBack.png");
  fourthFrame = loadImage("images/narration/frameOneAfterLevelOne.jpg");
  fifthFrame = loadImage("images/narration/frameTwoAfterLevelOne.jpg");
  sixthFrame = loadImage("images/narration/frameOneAfterLevelTwo.jpg");
  seventhFrame = loadImage("images/narration/frameTwoAfterLevelTwo.jpg");
  seventhFrameElcri = loadImage("images/narration/seventhFrameElcri.png");
  eigthFrame = loadImage("images/narration/frameAfterLevelThree.jpg");
  choiceFrame = loadImage("images/narration/choiceFrame.jpg");
  killTagonFrame = loadImage("images/narration/killTagon.jpg");
  killTagonElcri = loadImage("images/narration/killTagonElcri.png");
  spareTagon = loadImage("images/narration/spareTagon.jpg");
  spareArrow = loadImage("images/narration/arrow.png");
  togetherEnding = loadImage("images/narration/togetherEnding.jpg");
  togetherElcri = loadImage("images/narration/togetherElcri.png");
  togetherTagon = loadImage("images/narration/togetherTagon.png");
  aloneEnding = loadImage("images/narration/aloneEnding.jpg");
      
  //tile instantiation for all 3 levels
  boolean wall;
  for(int i=0; i<levelOne.length; i++) {
    for(int j=0; j<levelOne[i].length; j++) {
      if (levelOne[i][j] == 0) {
        wall = false;
      } else { wall = true; }
      if (levelOne[i][j] == 2) {
        ba1.add(new BasicEnemy(new PVector(j*tileSize, i*tileSize), "Mountain One")); 
        wall = false; 
        levelOne[i][j]= 0; 
      }
      if (levelOne[i][j] == 3) {
        ba1.add(new BasicEnemy(new PVector(j*tileSize, i*tileSize), "Mountain Two")); 
        wall = false;
        levelOne[i][j]= 0;
      }
      if (levelOne[i][j] == 4) {
        pu1.add(new PowerUp(new PVector(j*tileSize, i*tileSize)));
        wall = false;
        levelOne[i][j] = 0;
      }
      if (levelOne[i][j] == 5) {
        healthPack1 = new PowerUp(new PVector(j*tileSize, i*tileSize));
        wall = false;
        levelOne[i][j] = 0;
      }
      if (levelOne[i][j] == 6) {
        elcri = new Princess(new PVector(j*tileSize, i*tileSize));
        wall = false;
        levelOne[i][j] = 0;
      }
      if (levelOne[i][j] == 11) {
        tagon = new Abductor(new PVector(j*tileSize, i*tileSize));
        wall = false;
        levelOne[i][j] = 0;
      }
      String path = "images/tilesOne/tile"+levelOne[i][j]+".jpg";
      tilesOne.add(new Tile(path, new PVector(j*tileSize, i*tileSize), wall));
    }
  }
  
  for(int i=0; i<levelTwo.length; i++) {
    for(int j=0; j<levelTwo[i].length; j++) {
      if (levelTwo[i][j] == 0) {
        wall = false;
      } else { wall = true; }
      if (levelTwo[i][j] == 4) {
        pu2.add(new PowerUp(new PVector(j*tileSize, i*tileSize)));
        wall = false;
        levelTwo[i][j] = 0;
      }
      if (levelTwo[i][j] == 5) {
        healthPack2 = new PowerUp(new PVector(j*tileSize, i*tileSize));
        wall = false;
        levelTwo[i][j] = 0;
      }
      if (levelTwo[i][j] == 6) {
        wall = false;
        levelTwo[i][j] = 0;
      }
      if (levelTwo[i][j] == 11) {
        wall = false;
        levelTwo[i][j] = 0;
      }
      if (levelTwo[i][j] == 7) {
         ba2.add(new BasicEnemy(new PVector(j*tileSize, i*tileSize), "Ocean One"));
         wall = false;
         levelTwo[i][j] = 0;
      }
      if (levelTwo[i][j] == 8) {
        ba2.add(new BasicEnemy(new PVector (j*tileSize, i*tileSize), "Ocean Two"));
        wall = false;
        levelTwo[i][j] = 0;
      }
      String path = "images/tilesTwo/tile"+levelTwo[i][j]+".jpg";
      tilesTwo.add(new Tile(path, new PVector(j*tileSize, i*tileSize), wall));
    }
  }
  
  for(int i=0; i<levelThree.length; i++) {
    for(int j=0; j<levelThree[i].length; j++) {
      if (levelThree[i][j] == 0) {
        wall = false;
      } else { wall = true; }
      if (levelThree[i][j] == 4) {
        pu3.add(new PowerUp(new PVector(j*tileSize, i*tileSize)));
        wall = false;
        levelThree[i][j] = 0;
      }
      if (levelThree[i][j] == 5) {
        healthPack3 = new PowerUp(new PVector(j*tileSize, i*tileSize));
        wall = false;
        levelThree[i][j] = 0;
      }
      if (levelThree[i][j] == 6) {
        wall = false;
        levelThree[i][j] = 0;
      }
      if (levelThree[i][j] == 11) {
        wall = false;
        levelThree[i][j] = 0;
      }
      if (levelThree[i][j] == 9) {
         ba3.add(new BasicEnemy(new PVector(j*tileSize, i*tileSize), "Forest One"));
         wall = false;
         levelThree[i][j] = 0;
      }
      if (levelThree[i][j] == 10) {
        ba3.add(new BasicEnemy(new PVector (j*tileSize, i*tileSize), "Forest Two"));
        wall = false;
        levelThree[i][j] = 0;
      }
      String path = "images/tilesThree/tile"+levelThree[i][j]+".jpg";
      tilesThree.add(new Tile(path, new PVector(j*tileSize, i*tileSize), wall));
    }
  }
}
  
void draw () {
  //state switching
  switch(state) {
    case NARRATION: narration(); break;
    case START: startScreen(); break;
    case LEVEL_ONE: levelOne(); break;
    case LEVEL_TWO: levelTwo(); break;
    case LEVEL_THREE: levelThree(); break;
    case BOSS: bassBattle(); break;
    case LOSE: gameOver(); break;
    case WIN: winScreen(); break;
    case INSTRUCTIONS: instructions(); break; 
  }
}
  
//HUD function displaying health, score and current power up
void HUD () {
  noStroke();
  fill(235, 250, 210);
  rectMode(CENTER);
  rect(0, height-20, width*3, 95);
  fill(0);
  textSize(35);
  text("Health: "+elcri.health+"    |    Score: "+score +"    |    Current Power Up: ", 50, height-15);
  
  //boss battle addition for tagon health
  if (state == BOSS) {
    fill(195, 214, 162);
    rect(0, height-90, width*3, 45);
    fill(250, 85, 55);
    rectMode(CORNER);
    rect(245, height-103, tagon.health*35, 20);
    rectMode(CENTER);
    fill(0);
    text("Tagon Health: ", 50, height-80);
  }
  
  //activating power up
  //speed type
  if (curPU > 0 && curPUType == 0) {
    if (powerUpUsed) return;
    pushMatrix();
    translate(680, 570);
    fill(255, 0, 70);
    stroke(0);
    triangle(0, 10, -20, 0, 0, -10);
    popMatrix();
    textSize(28);
    fill(0);
    text("Speed", 700, 580);
  }
  
  //freeze type
  if (curPU > 0 && curPUType == 1) {
    if (powerUpUsed) return;
    pushMatrix();
    translate(680, 570);
    fill(135, 200, 255);
    stroke(0);
    triangle(0, 10, -20, 0, 0, -10);
    popMatrix();
    textSize(28);
    fill(0);
    text("Freeze", 700, 580);
  }
}