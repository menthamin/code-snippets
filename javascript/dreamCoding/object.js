// Objects

const name = 'min';
const age = 4;
console.log(name, age);

const obj1 = {}; // 'object literal' syntax
const obj2 = new Object(); // 'object constructor' syntax

function print(person) {
    console.log(person.name);
    console.log(person.age);
}

const jongmin = {name: 'jongmin', age: 4};
print(jongmin);

// with JavaScript magic (dynamically typed language)
jongmin.hasJob = true;
console.log(jongmin.hasJob);

delete jongmin.hasJob;
console.log(jongmin.hasJob);

// 2. Computed properties
// key should be always string
console.log(jongmin.name);
console.log(jongmin['name']);
jongmin['hasJob'] = true;
console.log(jongmin.hasJob);

function printValue(obj, key) {
    console.log(obj[key]);
}
printValue(jongmin, 'name');

// 3. Property value shorthand
const person1 = {name: 'bob', age: 2};
const person2 = {name: 'steve', age: 3};
const person3 = {name: 'dave', age: 4}
const person4 = new Person('min', 30);
console.log(person4);

// 4. Constructor Function
function Person(name, age) {
    this.name = name
    this.age = age;
}

// 5. in operator: property existence check (key in obj)
console.log('name' in jongmin);
console.log('age' in jongmin);
console.log('random' in jongmin);
console.log(jongmin.random);

// 6. for..in vs for..of
// for (key in obj)
console.clear();
for (key in jongmin) {
    console.log(key);
    console.log(jongmin[key]);
}

// for (value of iterable)
const array = [1, 2, 4, 5];
console.clear();
for (value of array) {
    console.log(value);
}

// 7. Fun cloning
// Object.assign(dest, [obj1, obj2, obj3...])
const user = { name: 'min', age: '20'};
const user2 = user
// user2.name = 'coder';
console.log(user);

// old way
const user3 = {};
for (key in user) {
    user3[key] = user[key];
}
console.clear();
console.log(user3);

// new way
const user4 = {};
Object.assign(user4, jongmin);
const user5 = Object.assign({}, jongmin);
console.log(user4, user5);
const user6 = {};


// another example
const fruit1 = {color: 'red'};
const fruit2 = {color: 'blue', size: 'big'};
const mixed = Object.assign({}, fruit1, fruit2);
console.clear();
console.log(mixed.color);
console.log(mixed.size);

const bank1 = {bankCode: '011'};
const bank2 = {bankCode: null};
const request = Object.assign({}, bank1, bank2)
console.log(request)



