import { Course } from 'src/courses/entities/course.entity';
import { Question } from 'src/questions/entities/question.entity';
import {
  Column,
  Entity,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
  OneToMany,
} from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';

@Entity('topics')
export class Topic {
  @ApiProperty({
    description: 'Identificador único del tema',
    example: 'd1e9f16b-23b4-4c7f-9187-8fc8f76d8f6c',
    uniqueItems: true,
  })
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ApiProperty({
    description: 'Nombre del tema',
    example: 'Álgebra',
  })
  @Column('text')
  nombre: string;

  @ApiProperty({
    description: 'Descripción del tema',
    example: 'Tema sobre álgebra básica',
  })
  @Column('text')
  descripcion: string;

  @ApiProperty({
    description: 'URL del video asociado al tema',
    example: 'https://example.com/video.mp4',
    nullable: true,
  })
  @Column('text', { nullable: true })
  url_video: string;

  @ApiProperty({
    description: 'URL de la imagen asociada al tema',
    example: 'https://example.com/image.jpg',
    nullable: true,
  })
  @Column('text', { nullable: true })
  url_imagen: string;

  @ApiProperty({
    description: 'Curso al que pertenece el tema',
    type: () => Course,
  })
  @ManyToOne(() => Course, (course) => course.topics, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'course_id' })
  course: Course;

  @OneToMany(() => Question, (question) => question.topic)
  questions: Question[];
}
