CREATE TABLE IF NOT EXISTS city(
	city_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
	city_name VARCHAR(60) NOT NULL,
	PRIMARY KEY(city_id)
);

CREATE TABLE IF NOT EXISTS university(
	university_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
	university_name VARCHAR(90) UNIQUE NOT NULL,
	city_id INT NOT NULL,
	compaign_date_begin DATE,
	compaign_date_end DATE,
	PRIMARY KEY(university_id),
	FOREIGN KEY(city_id) REFERENCES city(city_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS faculty(
	faculty_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
	faculty_name VARCHAR(90) NOT NULL,
	university_id INT NOT NULL,
	PRIMARY KEY(faculty_id),
	FOREIGN KEY(university_id) REFERENCES university(university_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT unique_faculty UNIQUE (faculty_name, university_id)
);

CREATE TABLE IF NOT EXISTS department(
	department_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
	department_name VARCHAR(90) NOT NULL,
	faculty_id INT NOT NULL,
	PRIMARY KEY(department_id),
	FOREIGN KEY(faculty_id) REFERENCES faculty(faculty_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT unique_department UNIQUE (department_name, faculty_id)
);

CREATE TABLE IF NOT EXISTS direction(
	direction_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
	direction_name VARCHAR(90) NOT NULL,
	direction_code VARCHAR(10) UNIQUE NOT NULL,
	PRIMARY KEY(direction_id)
);

CREATE TABLE IF NOT EXISTS specialization(
	specialization_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
	specialization_name VARCHAR(90) NOT NULL,
	direction_id INT NOT NULL,
	department_id INT NOT NULL,
	PRIMARY KEY(specialization_id),
	FOREIGN KEY(direction_id) REFERENCES direction(direction_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(department_id) REFERENCES department(department_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS exam(
	exam_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
	subject VARCHAR(90) UNIQUE NOT NULL,
	PRIMARY KEY(exam_id)
);

CREATE TABLE IF NOT EXISTS direction_exam(
	exam_id INT NOT NULL,
	direction_id INT NOT NULL,
	isRequired BOOL DEFAULT FALSE,
	PRIMARY KEY(exam_id, direction_id),
	FOREIGN KEY(exam_id) REFERENCES exam(exam_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(direction_id) REFERENCES direction(direction_id) ON DELETE CASCADE ON UPDATE CASCADE
);