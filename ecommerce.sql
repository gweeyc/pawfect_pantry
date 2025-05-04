CREATE TABLE auth_user (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(128) NOT NULL,
    email VARCHAR(254),
    first_name VARCHAR(30),
    last_name VARCHAR(150)
);

CREATE TABLE user_profile (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    bio TEXT,
    is_admin BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES auth_user(id)
);

CREATE TABLE category (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE,
    slug VARCHAR(100) UNIQUE,
    banner_image VARCHAR(255),
    description TEXT
);

CREATE TABLE product (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    tags VARCHAR(500),
    category VARCHAR(100),
    description TEXT,
    price DECIMAL(8,2),
    stock INTEGER,
    image VARCHAR(255),
    views INTEGER DEFAULT 0
);

CREATE TABLE order_order (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER,
    full_name VARCHAR(255),
    phone VARCHAR(20),
    address TEXT,
    note TEXT,
    total DECIMAL(10,2),
    status VARCHAR(50) DEFAULT 'Pending',
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES auth_user(id)
);

CREATE TABLE order_status_history (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    order_id INTEGER,
    status VARCHAR(50),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES order_order(id)
);

CREATE TABLE order_item (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER DEFAULT 1,
    price DECIMAL(8,2),
    FOREIGN KEY (order_id) REFERENCES order_order(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE TABLE cart_item (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER,
    order_id INTEGER,
    product_id INTEGER,
    price DECIMAL(10,2),
    quantity INTEGER DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES auth_user(id),
    FOREIGN KEY (order_id) REFERENCES order_order(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE TABLE feedback (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    product_id INTEGER,
    user_id INTEGER,
    comment TEXT,
    sentiment VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (user_id) REFERENCES auth_user(id)
);

