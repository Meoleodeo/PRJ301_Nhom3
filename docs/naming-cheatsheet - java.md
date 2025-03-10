# Naming cheatsheet

-   [English language](#english-language)
-   [Naming convention](#naming-convention)
-   [S-I-D](#s-i-d)
-   [Avoid contractions](#avoid-contractions)
-   [Avoid context duplication](#avoid-context-duplication)
-   [Reflect the expected result](#reflect-the-expected-result)
-   [Naming functions](#naming-functions)
    -   [A/HC/LC pattern](#ahclc-pattern)
        -   [Actions](#actions)
        -   [Context](#context)
        -   [Prefixes](#prefixes)
-   [Singular and Plurals](#singular-and-plurals)

---

Naming things is hard. This sheet attempts to make it easier.

Although these suggestions can be applied to any programming language, I will use JavaScript to illustrate them in practice.

## English language

Use English language when naming your variables and functions.

```java
/* Bad */
public class Persona {
    String primerNombre = "Gustavo";
    List<String> amigos = Arrays.asList("Kate", "John");
}

/* Good */
public class Person {
    String firstName = "Gustavo";
    List<String> friends = Arrays.asList("Kate", "John");
}
```

> Like it or not, English is the dominant language in programming: the syntax of all programming languages is written in English, as well as countless documentations and educational materials. By writing your code in English you dramatically increase its cohesiveness.

## Naming convention

Pick **camelCase** naming convention and follow it.

```java
/* Bad */
public class Example {
    int page_count = 5;
    boolean active = true;
    boolean ShouldUpdate = true;
}

/* Good */
public class Example {
    int pageCount = 5;
    boolean isActive = true;
    boolean shouldUpdate = true;
}
```

## S-I-D

A name must be _short_, _intuitive_ and _descriptive_:

-   **Short**. A name must not take long to type and, therefore, remember;
-   **Intuitive**. A name must read naturally, as close to the common speech as possible;
-   **Descriptive**. A name must reflect what it does/possesses in the most efficient way.

```java
/* Bad */
int a = 5; // "a" could mean anything
boolean isPaginatable = a > 10; // "Paginatable" sounds unnatural
boolean shouldPaginatize = a > 10; // Made-up verbs are not helpful

/* Good */
int postCount = 5;
boolean hasPagination = postCount > 10;
boolean shouldPaginate = postCount > 10; // alternatively
```

## Avoid contractions

Do **not** use contractions. They contribute to nothing but decreased readability of the code. Finding a short, descriptive name may be hard, but contraction is not an excuse for not doing so.

```java
/* Bad */
public class User {
    String getUsrNme() {
        return "username";
    }
}

/* Good */
public class User {
    String getUserName() {
        return "username";
    }
}
```

## Avoid context duplication

A name should not duplicate the context in which it is defined. Always remove the context from a name if that doesn't decrease its readability.

```java
public class UserService {
    /* Method name duplicates the context (which is "User") */
    public Settings getUserSettings(Event event) {
        // ...
        return new Settings();
    }

    /* Reads nicely as `userService.getSettings()` */
    public Settings getSettings(Event event) {
        // ...
        return new Settings();
    }
}
```

## Reflect the expected result

A name should reflect the expected result.

```java
/* Bad */
int itemCount = 3;
boolean isEnabled = itemCount > 3;
if (!isEnabled) {
    // ...
}

/* Good */
int itemCount = 3;
boolean isDisabled = itemCount <= 3;
if (isDisabled) {
    // ...
}
```

---

# Naming functions

## A/HC/LC Pattern

There is a useful pattern to follow when naming functions:

```
prefix? + action (A) + high context (HC) + low context? (LC)
```

Take a look at how this pattern may be applied in the table below.

| Name                   | Prefix   | Action (A) | High context (HC) | Low context (LC) |
| ---------------------- | -------- | ---------- | ----------------- | ---------------- |
| `getUser`              |          | `get`      | `User`            |                  |
| `getUserMessages`      |          | `get`      | `User`            | `Messages`       |
| `shouldDisplayMessage` | `should` | `Display`  | `Message`         |                  |
| `isPaymentEnabled`     | `is`     | `Enabled`  | `Payment`         |                  |

---

## Actions

The verb part of your function name. The most important part responsible for describing what the function _does_.

### `get`

Accesses data immediately (i.e. shorthand getter of internal data).

```java
public class User {
    private String firstName;
    private String lastName;

    public String getUserFullName() {
        return firstName + " " + lastName;
    }
}
```

> See also [compose](#compose).

### `set`

Sets a variable in a declarative way, with value `A` to value `B`.

```java
public class Counter {
    private int fruits = 0;

    public void setFruits(int nextFruits) {
        this.fruits = nextFruits;
    }

    public int getFruits() {
        return fruits;
    }
}

Counter counter = new Counter();
counter.setFruits(5);
System.out.println(counter.getFruits()); // 5
```

### `reset`

Sets a variable back to its initial value or state.

```java
public class Counter {
    private final int initialFruits = 5;
    private int fruits = initialFruits;

    public void setFruits(int nextFruits) {
        this.fruits = nextFruits;
    }

    public void resetFruits() {
        this.fruits = initialFruits;
    }

    public int getFruits() {
        return fruits;
    }
}

Counter counter = new Counter();
counter.setFruits(10);
System.out.println(counter.getFruits()); // 10
counter.resetFruits();
System.out.println(counter.getFruits()); // 5
```

### `fetch`

Request for some data, which takes some indeterminate time (i.e. database request).

```java
public class UserRepository {
    public List<User> fetchUsers() {
        // Simulating a database query
        return userDatabase.createQuery()
            .where("isActive = true")
            .findAll();
    }
}
```

### `remove`

Removes something _from_ somewhere.

For example, if you have a collection of selected filters on a search page, removing one of them from the collection is `removeFilter`, **not** `deleteFilter` (and this is how you would naturally say it in English as well):

```java
public class FilterManager {
    public List<String> removeFilter(List<String> filters, String filterName) {
        List<String> updatedFilters = new ArrayList<>(filters);
        updatedFilters.remove(filterName);
        return updatedFilters;
    }
}

List<String> selectedFilters = new ArrayList<>(Arrays.asList("price", "availability", "size"));
FilterManager manager = new FilterManager();
selectedFilters = manager.removeFilter(selectedFilters, "price");
```

> See also [delete](#delete).

### `delete`

Completely erases something from the realms of existence.

Imagine you are a content editor, and there is that notorious post you wish to get rid of. Once you clicked a shiny "Delete post" button, the CMS performed a `deletePost` action, **not** `removePost`.

```java
public class UserRepository {
    public void deleteUser(int id) {
        userDatabase.deleteById(id);
    }
}
```

> See also [remove](#remove).

### `compose`

Creates new data from the existing one. Mostly applicable to strings, objects, or functions.

```java
public class PageUtil {
    public String composePageUrl(String pageName, int pageId) {
        return pageName.toLowerCase() + "-" + pageId;
    }
}
```

> See also [get](#get).

---

## Context

A domain that a function operates on.

A function is often an action on _something_. It is important to state what its operable domain is, or at least an expected data type.

```java
/* A pure method operating with generics */
public class Utils {
    public <T> List<T> filter(List<T> list, Predicate<T> predicate) {
        return list.stream().filter(predicate).collect(Collectors.toList());
    }
}

/* Method operating exactly on posts */
public class PostManager {
    public List<Post> getRecentPosts(List<Post> posts) {
        return posts.stream()
            .filter(post -> post.getDate().equals(new Date()))
            .collect(Collectors.toList());
    }
}
```

> Some language-specific assumptions may allow omitting the context. For example, in JavaScript, it's common that `filter` operates on Array. Adding explicit `filterArray` would be unnecessary.

--

## Prefixes

Prefix enhances the meaning of a variable. It is rarely used in function names.

### `is`

Describes a characteristic or state of the current context (usually `boolean`).

```java
public class ColorChecker {
    private String color = "blue";

    public boolean isBlue() {
        return color.equals("blue"); // characteristic
    }

    public boolean isPresent() {
        return true; // state
    }
}

ColorChecker checker = new ColorChecker();
if (checker.isBlue() && checker.isPresent()) {
    System.out.println("Blue is present!");
}
```

### `has`

Describes whether the current context possesses a certain value or state (usually `boolean`).

```java
/* Bad */
public class ProductManager {
    private int productsCount = 5;
    public boolean isProductsExist() {
        return productsCount > 0;
    }
}

/* Good */
public class ProductManager {
    private int productsCount = 5;
    public boolean hasProducts() {
        return productsCount > 0;
    }
}
```

### `should`

Reflects a positive conditional statement (usually `boolean`) coupled with a certain action.

```java
public class UrlManager {
    public boolean shouldUpdateUrl(String url, String expectedUrl) {
        return !url.equals(expectedUrl);
    }
}
```

### `min`/`max`

Represents a minimum or maximum value. Used when describing boundaries or limits.

```java
public class PostRenderer {
    /**
     * Renders a random amount of posts within
     * the given min/max boundaries.
     */
    public List<Post> renderPosts(List<Post> posts, int minPosts, int maxPosts) {
        Random random = new Random();
        int count = minPosts + random.nextInt(maxPosts - minPosts + 1);
        return posts.subList(0, Math.min(count, posts.size()));
    }
}
```

## Singular and Plurals

Like a prefix, variable names can be made singular or plural depending on whether they hold a single value or multiple values.

```java
/* Bad */
public class Example {
    String friends = "Bob"; // Singular name for a single value
    List<String> friend = Arrays.asList("Bob", "Tony", "Tanya"); // Plural content with singular name
}

/* Good */
public class Example {
    String friend = "Bob";
    List<String> friends = Arrays.asList("Bob", "Tony", "Tanya");
}
```
