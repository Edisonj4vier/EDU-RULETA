import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Course } from '../../courses/entities/course.entity';
import { User } from 'src/auth/entities/auth.entity';

@Entity('student_courses')
export class StudentCourse {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => User, (user) => user.studentCourses, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'estudiante_id' })
  user: User;

  @ManyToOne(() => Course, (course) => course.studentCourses, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'course_id' })
  course: Course;

  @Column('float', { nullable: true })
  puntuacion: number;

  @Column('timestamp', { default: () => 'CURRENT_TIMESTAMP' })
  fecha_inscripcion: Date;
}
