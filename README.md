# Truong Nguyen Blog: Basic rails 5 application with devise

This application has responsive mobile view and navigation, twitter bootstrap, devise, rails 5.0.0 and slim setup.

important features are:

* ruby version 2.3.0

* rails version 5.0.0

### Devise configured modules are:

* user log in

* user registration

* edit user

### Important instructions:

* [strong parameters](https://github.com/plataformatec/devise#strong-parameters): if you add any new user attribute like I have added user first name and last name than you have to add those new attributes to permitted parameters configured inside application controller. 

### What have I missed:
I have missed several devise features like email confirmation, reset password, forget password, email handling of devise. I will cover them in my next rails 5 basic application, coming soon IA.

### Setup

``` Bundle install ```

``` rails db:create db:migrate db:seed ```

API Search:

```
https://truongnguyenblog.herokuapp.com/api/v1/posts/index?q[content_filtered_cont]=If you want to be a leader who attracts quality people
```