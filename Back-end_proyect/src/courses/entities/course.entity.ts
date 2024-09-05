import {
  Column,
  Entity,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
  OneToMany,
} from 'typeorm';
import { User } from '../../auth/entities/auth.entity'; // Asegúrate de que la ruta sea correcta
import { Topic } from 'src/topics/entities/topic.entity';
import { StudentCourse } from 'src/student_course/entities/student_course.entity';
import { ApiProperty } from '@nestjs/swagger';
@Entity('courses')
export class Course {
  @ApiProperty({
    example: 'cd7b3b7e-1b1b-4b3b-8b3b-7e1b1b4b3b8b',
    description: 'Identificador único del curso',
    uniqueItems: true,
  })
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ApiProperty({
    example: 'Matemáticas',
    description: 'Nombre del curso',
  })
  @Column('text')
  nombre: string;

  @ApiProperty({
    example: 'Curso de matemáticas básicas',
    description: 'Descripción del curso',
  })
  @Column('text')
  descripcion: string;

  @ApiProperty({
    example: 'MATG101',
    description: 'Código de acceso al curso',
  })
  @Column('text', { unique: true })
  codigo_acceso: string;

  @ApiProperty({
    example: 30,
    description: 'Tiempo en minutos para responder cada pregunta',
  })
  @Column('int', { default: 30 })
  temporizador: number;

  @ApiProperty({
    description: 'Usuario que creó el curso',
    type: () => User,
  })
  @ManyToOne(() => User, (user) => user.courses, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user: User;

  @OneToMany(() => Topic, (topic) => topic.course)
  topics: Topic[];

  @OneToMany(() => StudentCourse, (studentCourse) => studentCourse.course)
  studentCourses: StudentCourse[];
}
