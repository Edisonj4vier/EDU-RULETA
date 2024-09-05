import { ApiProperty } from '@nestjs/swagger';
import { Course } from 'src/courses/entities/course.entity';
import { StudentCourse } from 'src/student_course/entities/student_course.entity';
import {
  BeforeInsert,
  BeforeUpdate,
  Column,
  Entity,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('users')
export class User {
  @ApiProperty({
    description: 'Identificador único del usuario',
    example: 'b4e2234f-9234-4d8c-b98d-9c55df12a92c',
    uniqueItems: true,
  })
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ApiProperty({
    description: 'Correo electrónico del usuario',
    example: 'user@example.com',
    uniqueItems: true,
  })
  @Column('text', {
    unique: true,
  })
  email: string;

  @ApiProperty({
    description: 'Contraseña del usuario (no seleccionable)',
    example: 'password123',
    writeOnly: true,
  })
  @Column('text', {
    select: false,
  })
  password: string;

  @ApiProperty({
    description: 'Nombre completo del usuario',
    example: 'John Doe',
  })
  @Column('text')
  fullName: string;

  @ApiProperty({
    description: 'Estado de actividad del usuario',
    example: true,
  })
  @Column('bool', {
    default: true,
  })
  isActive: boolean;

  @ApiProperty({
    description: 'Roles asignados al usuario',
    example: ['student'],
    type: [String],
  })
  @Column('text', {
    array: true,
    default: ['student'],
  })
  roles: string[];

  @OneToMany(() => Course, (course) => course.user)
  courses: Course[];

  @OneToMany(() => StudentCourse, (studentCourse) => studentCourse.user)
  studentCourses: StudentCourse[];

  @BeforeInsert()
  checkFieldsBeforeInsert() {
    this.email = this.email.toLowerCase().trim();
  }

  @BeforeUpdate()
  checkFieldsBeforeUpdate() {
    this.checkFieldsBeforeInsert();
  }
}
