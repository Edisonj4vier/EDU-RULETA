import { Course } from 'src/courses/entities/course.entity';
import {
  Column,
  Entity,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';

@Entity('topics')
export class Topic {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column('text')
  nombre: string;

  @Column('text')
  descripcion: string;

  @Column('text', { nullable: true })
  url_video: string;

  @Column('text', { nullable: true })
  url_imagen: string;

  @Column('bigint')
  course_id: number;

  @ManyToOne(() => Course, (course) => course.topics)
  @JoinColumn({ name: 'course_id' })
  course: Course;
}
